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
import model.Atleta;
import persistence.AtletaDao;



@WebServlet("/atletaServelet")
public class AtletaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private List<Atleta> listAtletas= new ArrayList<>();

	   

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String acao = request.getParameter("acao");
		
		try {
			AtletaDao cDao = new AtletaDao();
			
			if(acao!=null) {
			
				if(acao.equals("ordenacaoAtleta")) {
					listAtletas=cDao.getAtletas();
				}
				
				if(acao.equals("ordenacaoMasculino")){
					listAtletas=cDao.getOrdenacaoMasculino();
				}
				
				if(acao.equals("ordenacaoFeminino")){
					listAtletas=cDao.getOrdenacaoFeminino();
				}
				
				if(acao.equals("ordenacaoPais")){
					listAtletas=cDao.getOrdenacaoPais();
				}
				
				if(acao.equals("ordenacaoProva")){
					listAtletas=cDao.getOrdenacaoProva();
				}
			}else {
				listAtletas=cDao.getAtletas();
			}
			
			
				
			
		} catch (ClassNotFoundException | SQLException e) {
			System.out.println("erro de banco de dados");
		} finally {
			RequestDispatcher rd = request.getRequestDispatcher("PAGINAS/atleta.jsp");
			request.setAttribute("list_Atletas",listAtletas);
			rd.forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}	
}
