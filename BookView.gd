extends CanvasLayer

@onready var book_list = self.get_node("BookList")
@onready var reader_view = self.get_node("ReaderView")
@onready var texture_rect = self.get_node("TextureRect")
@onready var prev_button = reader_view.get_node("PrevButton")
@onready var next_button = reader_view.get_node("NextButton")
@onready var close_button = self.get_node("CloseButton")
@onready var back_button = self.get_node("BackButton")

var current_book = ""
var current_page = 0
var book_pages = {
	"Book1": ["res://Assets/books/book1/page1.png", "res://Assets/books/book1/page2.png", "res://Assets/books/book1/page3.png"],
	"Book2": ["res://Assets/books/book2/page1.png", "res://Assets/books/book2/page2.png", "res://Assets/books/book2/page3.png"],
	"Book3": ["res://Assets/books/book3/page1.png", "res://Assets/books/book3/page2.png", "res://Assets/books/book3/page3.png"]
}

func _ready():
	print("Script is running")
	initialize_nodes()
	connect_buttons()
	hide_all()
	toggle_book_view()

func initialize_nodes():
	book_list = get_node_or_null("BookList")
	reader_view = get_node_or_null("ReaderView")
	texture_rect = get_node_or_null("TextureRect")
	if reader_view:
		prev_button = reader_view.get_node_or_null("PrevButton")
		next_button = reader_view.get_node_or_null("NextButton")
	close_button = get_node_or_null("CloseButton")
	back_button = get_node_or_null("BackButton")

func connect_buttons():
	print("connectbuttons")
	if book_list:
		for book in ["Book1", "Book2", "Book3"]:
			var button = book_list.get_node_or_null(book)
			if button:
				button.pressed.connect(_on_book_selected.bind(book))

func _on_book_selected(book: String):
	current_book = book
	current_page = 0
	update_reader_view()
	print("Book selected:", book)

func update_reader_view():
	print("lappen")
	if book_list:
		book_list.hide()
	if reader_view:
		reader_view.show()
	if texture_rect:
		print("if texture_rect and current_book in book_pages:")
		texture_rect.show()
		texture_rect.texture = load(book_pages[current_book][current_page])
	if prev_button:
		prev_button.disabled = current_page == 0
	if next_button:
		next_button.disabled = current_page == book_pages[current_book].size() - 1
	print("Reader view updated")

func _on_prev_button_pressed():
	if current_page > 0:
		current_page -= 1
		update_reader_view()
		print("Previous page")

func _on_next_button_pressed():
	if current_book in book_pages and current_page < book_pages[current_book].size() - 1:
		current_page += 1
		update_reader_view()
		print("Next page")

func _on_close_button_pressed():
	self.hide()
	

func _on_back_button_pressed():
	if reader_view:
		reader_view.hide()
		texture_rect.hide()
	if book_list:
		book_list.show()
	print("Back to book list")

func hide_all():
	if book_list:
		book_list.hide()
	if reader_view:
		reader_view.hide()
	print("All views hidden")

func toggle_book_view():
	print("toggle_book_view called")
	if (book_list and book_list.visible) or (reader_view and reader_view.visible):
		hide_all()
	elif book_list:
		book_list.show()
		if reader_view:
			reader_view.hide()
		print("Book list shown")

