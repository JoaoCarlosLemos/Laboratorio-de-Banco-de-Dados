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

import model.ParticipantesProva;
import persistence.ParticipantesProvaDao;



@WebServlet("/participantesServlet")
public class ParticipantesProvaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private List<ParticipantesProva> listParticipantesProva= new ArrayList<>();

	   

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String acao = request.getParameter("acao");
		String codigo_prova= request.getParameter("codigo_prova");
		
		Integer codigoProva= Integer.parseInt(codigo_prova);
		String descricaoProva="";
		String recordeGp="";
		String recordeMundial="";
		
		try {
			
			ParticipantesProvaDao cDao = new ParticipantesProvaDao();
			descricaoProva=cDao.chamadaProcedure(codigoProva);
			recordeGp=cDao.chamadaProcedureRecordeGp(codigoProva);
			recordeMundial=cDao.chamadaProcedureRecordeMundial(codigoProva);
			
			if(acao.equals("listarParticipantes")){
				Integer codProva= Integer.parseInt(codigo_prova);
				ParticipantesProvaDao pDao = new ParticipantesProvaDao();
				listParticipantesProva=pDao.getParticipantesProva(codProva);
			}
		} catch (ClassNotFoundException | SQLException e) {
			descricaoProva=e.getMessage();
			System.out.println(descricaoProva);
			System.out.println("erro de banco de dados");
		} finally {
			RequestDispatcher rd = request.getRequestDispatcher("PAGINAS/participantes.jsp");
			request.setAttribute("list_ParticipantesProva",listParticipantesProva);
			request.setAttribute("descricao_prova",descricaoProva);
			request.setAttribute("recorde_gp",recordeGp);
			request.setAttribute("recorde_mundial",recordeMundial);
			rd.forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}	
}
