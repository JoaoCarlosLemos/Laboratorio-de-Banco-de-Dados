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
import model.Bateria;
import persistence.BateriaInicialDao;
import persistence.ParticipantesProvaDao;



@WebServlet("/bateriasServlet")
public class BateriasServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private List<Bateria> listBateriaInicial= new ArrayList<>();
	private List<Bateria> listBateriaFinal= new ArrayList<>();
	private int colocacao=0;
	private int colocacaoF=0;



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
			
			
			if(acao.equals("listarBateriaInicial")){
				BateriaInicialDao bDao = new BateriaInicialDao();
				listBateriaInicial=bDao.getBateriaInicial(codigoProva);	
			}
			
			if(acao.equals("listarBateriaFinal")){
				BateriaInicialDao bDao = new BateriaInicialDao();
				listBateriaFinal=bDao.getBateriaFinal(codigoProva);	
			}
			
			
		} catch (ClassNotFoundException | SQLException e) {
			descricaoProva=e.getMessage();
			System.out.println(descricaoProva);
			System.out.println("erro de banco de dados");
		} finally {
			
			if(codigoProva>0 && codigoProva<7 ){
				RequestDispatcher rd = request.getRequestDispatcher("PAGINAS/bateriaB.jsp");
				request.setAttribute("descricao_prova",descricaoProva);
				request.setAttribute("recorde_gp",recordeGp);
				request.setAttribute("recorde_mundial",recordeMundial);
				request.setAttribute("codigo_prova",codigo_prova);
				try {
					BateriaInicialDao bDao = new BateriaInicialDao();
					listBateriaInicial=bDao.getBateriaInicial2(codigoProva);
					listBateriaFinal=bDao.getBateriaFinal2(codigoProva);
				}catch (ClassNotFoundException | SQLException e) {}finally {
					request.setAttribute("listBateriaInicial",listBateriaInicial);
					request.setAttribute("listBateriaFinal",listBateriaFinal);
				}
				request.setAttribute("colocacao",colocacao);
				request.setAttribute("colocacaoF",colocacaoF);
				rd.forward(request, response);
			}
			
			if(codigoProva>6 && codigoProva<17 ){
				RequestDispatcher rd = request.getRequestDispatcher("PAGINAS/bateriaA.jsp");
				request.setAttribute("descricao_prova",descricaoProva);
				request.setAttribute("recorde_gp",recordeGp);
				request.setAttribute("recorde_mundial",recordeMundial);
				request.setAttribute("codigo_prova",codigo_prova);
				try {
					BateriaInicialDao bDao = new BateriaInicialDao();
					listBateriaInicial=bDao.getBateriaInicial2(codigoProva);
					listBateriaFinal=bDao.getBateriaFinal2(codigoProva);
				}catch (ClassNotFoundException | SQLException e) {}finally {
					request.setAttribute("listBateriaInicial",listBateriaInicial);
					request.setAttribute("listBateriaFinal",listBateriaFinal);
				}
				request.setAttribute("colocacao",colocacao);
				request.setAttribute("colocacaoF",colocacaoF);
				rd.forward(request, response);
			}	
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}	
}
