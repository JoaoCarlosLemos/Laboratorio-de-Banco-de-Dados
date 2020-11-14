package persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Atleta;


public class AtletaDao {
	
private Connection c;
	
	public AtletaDao() throws ClassNotFoundException, SQLException {
		GenericDao gDao = new GenericDao();
		c = gDao.getConnection();
	}
	

	public List<Atleta> getAtletas() throws SQLException {
		PreparedStatement ps = c.prepareStatement("SELECT atleta.codigo_atleta,atleta.nome,atleta.sexo,"
				+ "atleta.codigo_coi,coi.pais_coi,prova.descricao FROM atleta\r\n" + 
				"INNER JOIN  prova	ON atleta.codigo_prova = prova.codigo_prova\r\n" + 
				"INNER JOIN  coi	ON atleta.codigo_coi   = coi.codigo_coi ORDER BY atleta.nome");
		ResultSet rs= ps.executeQuery();
		List<Atleta>listAtletas = new ArrayList<>();
		while(rs.next()){
			listAtletas.add(new Atleta(rs.getInt(1), rs.getString(2),rs.getString(3),rs.getString(4), 
									   rs.getString(5),rs.getString(6)));	
		}
		return listAtletas;
	}


	public List<Atleta> getOrdenacaoMasculino()throws SQLException {
		PreparedStatement ps = c.prepareStatement("SELECT atleta.codigo_atleta,atleta.nome,atleta.sexo,"
				+ "atleta.codigo_coi,coi.pais_coi,prova.descricao FROM atleta\r\n" + 
				"INNER JOIN  prova	ON atleta.codigo_prova = prova.codigo_prova\r\n" + 
				"INNER JOIN  coi		ON atleta.codigo_coi = coi.codigo_coi WHERE atleta.sexo='Masculino' "
				+ "ORDER BY atleta.nome");
		ResultSet rs= ps.executeQuery();
		List<Atleta>listAtletas = new ArrayList<>();
		while(rs.next()){
			listAtletas.add(new Atleta(rs.getInt(1), rs.getString(2),rs.getString(3),rs.getString(4), 
									   rs.getString(5),rs.getString(6)));	
		}
		return listAtletas;
	}


	public List<Atleta> getOrdenacaoFeminino()throws SQLException{
		PreparedStatement ps = c.prepareStatement("SELECT atleta.codigo_atleta,atleta.nome,atleta.sexo,"
				+ "atleta.codigo_coi,coi.pais_coi,prova.descricao FROM atleta\r\n" + 
				"INNER JOIN  prova	ON atleta.codigo_prova = prova.codigo_prova\r\n" + 
				"INNER JOIN  coi		ON atleta.codigo_coi = coi.codigo_coi WHERE atleta.sexo='Feminino' "
				+ "ORDER BY atleta.nome");
		ResultSet rs= ps.executeQuery();
		List<Atleta>listAtletas = new ArrayList<>();
		while(rs.next()){
			listAtletas.add(new Atleta(rs.getInt(1), rs.getString(2),rs.getString(3),rs.getString(4), 
									   rs.getString(5),rs.getString(6)));	
		}
		return listAtletas;
	}


	public List<Atleta> getOrdenacaoPais() throws SQLException {
		PreparedStatement ps = c.prepareStatement("SELECT atleta.codigo_atleta,atleta.nome,atleta.sexo,"
				+ "atleta.codigo_coi,coi.pais_coi,prova.descricao FROM atleta\r\n" + 
				"INNER JOIN  prova	ON atleta.codigo_prova = prova.codigo_prova\r\n" + 
				"INNER JOIN  coi		ON atleta.codigo_coi = coi.codigo_coi ORDER BY coi.pais_coi");
		ResultSet rs= ps.executeQuery();
		List<Atleta>listAtletas = new ArrayList<>();
		while(rs.next()){
			listAtletas.add(new Atleta(rs.getInt(1), rs.getString(2),rs.getString(3),rs.getString(4), 
									   rs.getString(5),rs.getString(6)));	
		}
		return listAtletas;
	}


	public List<Atleta> getOrdenacaoProva() throws SQLException {
		PreparedStatement ps = c.prepareStatement("SELECT atleta.codigo_atleta,atleta.nome,atleta.sexo,"
				+ "atleta.codigo_coi,coi.pais_coi,prova.descricao FROM atleta\r\n" + 
				"INNER JOIN  prova	ON atleta.codigo_prova = prova.codigo_prova\r\n" + 
				"INNER JOIN  coi		ON atleta.codigo_coi = coi.codigo_coi ORDER BY prova.descricao");
		ResultSet rs= ps.executeQuery();
		List<Atleta>listAtletas = new ArrayList<>();
		while(rs.next()){
			listAtletas.add(new Atleta(rs.getInt(1), rs.getString(2),rs.getString(3),rs.getString(4), 
									   rs.getString(5),rs.getString(6)));	
		}
		return listAtletas;
	}
}















