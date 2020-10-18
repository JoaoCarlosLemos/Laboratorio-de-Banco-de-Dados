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

import model.ApuracaoPorQuesito;
import model.EscolaDeSamba;
import model.Parcial;
import persistence.ParcialDao;

@WebServlet("/apuracao")
public class ApuracaoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private List<ApuracaoPorQuesito> listAPQ= new ArrayList<>();
	private List<EscolaDeSamba> listEDS= new ArrayList<>();
	private int cont_j=0;
	private int cont_e=1;
	private int cont_q=1; 
	private int cont_d=1;
	private int colocacao=0;

    public ApuracaoServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(cont_j>=70 ) {cont_j=0;}
		if(cont_e>=14 ) {cont_e=0;}
		if(cont_q>=630) {cont_q=0;}
		
		cont_j=cont_j+1;
		cont_e=cont_e+1;
		cont_q=cont_q+1;
		cont_d=cont_d+1;
		
		Parcial p = new Parcial();
		p.setIdJurado(Integer.parseInt(request.getParameter("jurado")));
		p.setIdEscola(Integer.parseInt(request.getParameter("escola")));
		p.setIdQuesito(Integer.parseInt(request.getParameter("quesito")));
		p.setNota(Double.parseDouble(request.getParameter("nota")));

		try {
			ParcialDao cDao = new ParcialDao();
			cDao.chamadaProcedure(p);
			listAPQ=cDao.getAPQs(p);
			listEDS=cDao.getEDSs();
		} catch (ClassNotFoundException | SQLException e) {
			System.out.println("erro de banco de dados");
		} finally {
			RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
			request.setAttribute("cont_j",cont_j);
			request.setAttribute("cont_e",cont_e);
			request.setAttribute("cont_q",cont_q);
			request.setAttribute("cont_d",cont_d);
			request.setAttribute("colocacao",colocacao);
			
			request.setAttribute("list_APQ",listAPQ);
			request.setAttribute("list_EDS",listEDS);
			
			rd.forward(request, response);
		}	
	}	
}
