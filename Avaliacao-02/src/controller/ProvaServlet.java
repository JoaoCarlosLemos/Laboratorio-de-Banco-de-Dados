package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Prova;
import persistence.ProvaDao;

@WebServlet("/provaServelet")
public class ProvaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private List<Prova> listProvas= new ArrayList<>();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			ProvaDao cDao = new ProvaDao();
			listProvas=cDao.getProvas();
		} catch (ClassNotFoundException | SQLException e) {
			System.out.println("erro de banco de dados");
		} finally {
			RequestDispatcher rd = request.getRequestDispatcher("PAGINAS/gp.jsp");
			request.setAttribute("list_Provas",listProvas);
			rd.forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}
	
}
