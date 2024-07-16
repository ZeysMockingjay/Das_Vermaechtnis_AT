extends Area2D

var entered = false
var current_book = ""
var current_page = 0
var current_view = null
var book_pages = {
	"Book1": ["res://assets/books/book1/page1.png", "res://assets/books/book1/page2.png", "res://assets/books/book1/page3.png"],
	"Book2": ["res://assets/books/book2/page1.png", "res://assets/books/book2/page2.png", "res://assets/books/book2/page3.png"],
	"Book3": ["res://assets/books/book3/page1.png", "res://assets/books/book3/page2.png", "res://assets/books/book3/page3.png"]
}

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_Area2D_body_entered"))
	connect("body_exited", Callable(self, "_on_Area2D_body_exited"))

func _on_Area2D_body_entered(body: Node) -> void:
	if body is CharacterBody2D:
		entered = true

func _on_Area2D_body_exited(body: Node) -> void:
	if body is CharacterBody2D:
		entered = false

func _physics_process(_delta: float) -> void:
	if entered and Input.is_action_just_pressed("ui_accept"):
		if current_view:
			close_book_view()
		else:
			open_book_view()

func open_book_view():
	current_view = Control.new()
	current_view.set_anchors_preset(Control.PRESET_FULL_RECT)
	get_tree().root.add_child(current_view)
	
	var book_selection = VBoxContainer.new()
	book_selection.set_anchors_preset(Control.PRESET_CENTER)
	current_view.add_child(book_selection)
	
	for book in book_pages.keys():
		var button = Button.new()
		button.text = book
		button.connect("pressed", Callable(self, "_on_book_selected").bind(book))
		book_selection.add_child(button)
	
	var reader_view = Control.new()
	reader_view.set_anchors_preset(Control.PRESET_FULL_RECT)
	reader_view.hide()
	current_view.add_child(reader_view)
	
	var texture_rect = TextureRect.new()
	texture_rect.set_anchors_preset(Control.PRESET_CENTER)
	texture_rect.expand_mode = TextureRect.EXPAND_KEEP_SIZE
	texture_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	reader_view.add_child(texture_rect)
	
	var prev_button = Button.new()
	prev_button.text = "Previous"
	prev_button.position = Vector2(20, 20)
	prev_button.connect("pressed", Callable(self, "_on_prev_page"))
	reader_view.add_child(prev_button)
	
	var next_button = Button.new()
	next_button.text = "Next"
	next_button.position = Vector2(120, 20)
	next_button.connect("pressed", Callable(self, "_on_next_page"))
	reader_view.add_child(next_button)
	
	var back_button = Button.new()
	back_button.text = "Back"
	back_button.position = Vector2(220, 20)
	back_button.connect("pressed", Callable(self, "_on_back_pressed"))
	reader_view.add_child(back_button)
	
	var page_label = Label.new()
	page_label.position = Vector2(20, 60)
	reader_view.add_child(page_label)

func close_book_view():
	if current_view:
		current_view.queue_free()
		current_view = null

func _on_book_selected(book):
	current_book = book
	current_page = 0
	update_reader_view()

func update_reader_view():
	var reader_view = current_view.get_child(1)  # The second child is the reader view
	reader_view.show()
	current_view.get_child(0).hide()  # Hide book selection view
	
	var texture_rect = reader_view.get_child(0)
	texture_rect.texture = load(book_pages[current_book][current_page])
	var page_label = reader_view.get_child(4)
	page_label.text = "Page " + str(current_page + 1) + " of " + str(book_pages[current_book].size())

func _on_prev_page():
	if current_page > 0:
		current_page -= 1
		update_reader_view()

func _on_next_page():
	if current_page < book_pages[current_book].size() - 1:
		current_page += 1
		update_reader_view()

func _on_back_pressed():
	current_view.get_child(1).hide()  # Hide reader view
	current_view.get_child(0).show()  # Show book selection view
