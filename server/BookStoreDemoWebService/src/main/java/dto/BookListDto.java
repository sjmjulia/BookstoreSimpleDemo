package dto;

import model.Book;

import java.util.List;

/**
 * Created by julia on 5/28/17.
 */
public class BookListDto {
    private List<Book> books;

    public BookListDto(List<Book> books) {
        this.books = books;
    }

    public List<Book> getBooks() {
        return books;
    }

    public void setBooks(List<Book> books) {
        this.books = books;
    }
}
