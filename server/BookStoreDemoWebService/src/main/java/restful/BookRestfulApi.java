package restful;

import java.util.ArrayList;
import java.util.List;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import dto.BookListDto;
import dto.ResultDTO;

import model.Book;
import service.AppService;
import util.SpringContextUtil;

 
@Path("/")
public class BookRestfulApi
{

	private AppService appService=(AppService) SpringContextUtil.getBean("appService");

	@GET
	@Produces("text/html")
	public Response getStartingPage()
	{
		String output = "<h1>No Zuo No Die!<h1>";
		return Response.status(200).entity(output).build();
	}
	
	@GET
	@Path("/getBooks")
	@Produces(MediaType.APPLICATION_JSON)
	public BookListDto AllBooks()
	{
		System.out.println("getBooks");
		List<Book> books = appService.getAllBooks();

		return new BookListDto(books);
	}
	
	 @POST
     @Path("/addBook")
	 @Produces(MediaType.APPLICATION_JSON)
//	 @Consumes(MediaType.APPLICATION_JSON)
     public ResultDTO addBook(Book book){
		 System.out.println("addBook");
		 appService.addBook(book);
		 return new ResultDTO(1);
     }

	 
	 @POST
     @Path("/updateBook")
     @Produces(MediaType.APPLICATION_JSON)
     public ResultDTO updateBook(Book book){
		 System.out.println("updateBook");
		 appService.updateBook(book);
		 return new ResultDTO(1);
     }
	 
	 @GET
     @Path("/deleteBook/{id}")
     @Produces(MediaType.APPLICATION_JSON)
     public ResultDTO deleteById(@PathParam("id") int id){
		 System.out.println("deleteBook");
		 appService.deleteBookById(id);
		 return new ResultDTO(1);
     }
	
}