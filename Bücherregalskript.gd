extends Node2D

var entered = false
var bib_regalview_scene = preload("res://Bib_Regalview.tscn")
var current_view = null
var current_book = ""
var current_page = 0

# Dictionary to store book pages
var book_pages = {
	"Book1": [],
	"Book2": [],
	"Book3": []
}

func _ready():
	var parent = get_parent()
	if parent is Area2D:
		parent.connect("body_entered", Callable(self, "_on_Area2D_body_entered"))
		parent.connect("body_exited", Callable(self, "_on_Area2D_body_exited"))
	else:
		push_error("Parent node is not an Area2D. This script should be attached to a child of an Area2D.")
	
	# Load book pages
	for i in range(1, 4):
		var dir = DirAccess.open("res://assets/books/book" + str(i))
		if dir:
			dir.list_dir_begin()
			var file_name = dir.get_next()
			while file_name != "":
				if file_name.ends_with(".png") or file_name.ends_with(".jpg"):
					book_pages["Book" + str(i)].append("res://assets/books/book" + str(i) + "/" + file_name)
				file_name = dir.get_next()
		book_pages["Book" + str(i)].sort()  # Ensure pages are in order

func _on_Area2D_body_entered(body):
	if body is CharacterBody2D:
		entered = true

func _on_Area2D_body_exited(body):
	if body is CharacterBody2D:
		entered = false

func _unhandled_input(event):
	if entered and event.is_action_pressed("e"):
		if current_view:
			close_bib_regalview()
		else:
			open_bib_regalview()

func open_bib_regalview():
	current_view = bib_regalview_scene.instantiate()
	get_tree().root.add_child(current_view)
	setup_buttons()

func close_bib_regalview():
	if current_view:
		current_view.queue_free()
		current_view = null

func setup_buttons():
	var button_container = current_view.get_node("VBoxContainer")
	for book in book_pages.keys():
		var button = Button.new()
		button.text = book
		button.connect("pressed", Callable(self, "_on_book_selected").bind(book))
		button_container.add_child(button)

func _on_book_selected(book):
	current_book = book
	current_page = 0
	update_reader_view()

func update_reader_view():
	var reader_view = current_view.get_node("HBoxContainer")
	reader_view.show()
	
	# Clear existing pages
	for child in reader_view.get_children():
		if child is TextureRect:
			child.queue_free()
	
	# Add current page
	var texture_rect = TextureRect.new()
	texture_rect.texture = load(get_book_pages(current_book)[current_page])
	reader_view.add_child(texture_rect)

func get_book_pages(book):
	return book_pages[book]

func _on_prev_page():
	if current_page > 0:
		current_page -= 1
		update_reader_view()

func _on_next_page():
	if current_page < get_book_pages(current_book).size() - 1:
		current_page += 1
		update_reader_view()
