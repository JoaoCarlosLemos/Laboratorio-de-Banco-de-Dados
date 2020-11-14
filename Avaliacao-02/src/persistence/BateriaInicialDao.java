package persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Bateria;



public class BateriaInicialDao {
	
private Connection c;
	
	public BateriaInicialDao() throws ClassNotFoundException, SQLException {
		GenericDao gDao = new GenericDao();
		c = gDao.getConnection();
	}
	

	public List<Bateria> getBateriaInicial(Integer codProva) throws SQLException {
				
		if(codProva<7) {
			PreparedStatement ps = c.prepareStatement("INSERT INTO bateria_inicial SELECT * FROM fn_bateria_inicial("+codProva+") order by resultado desc");
			ps.execute();
		}
		
		if(codProva>6 && codProva<17) {
			PreparedStatement ps = c.prepareStatement("INSERT INTO bateria_inicial SELECT * FROM fn_bateria_inicial("+codProva+") order by resultado asc");
			ps.execute();
		}
		
		PreparedStatement ps = c.prepareStatement("SELECT codigo,codigo_tb,codigo_prova,codigo_atleta, nome,pais_coi,marca01,marca02,marca03,marca04,marca05,marca06,resultado FROM bateria_inicial WHERE codigo_prova='"+codProva+"'");
		ResultSet rs= ps.executeQuery();
		List<Bateria>listBateriaInicial = new ArrayList<>();
		while(rs.next()){
			listBateriaInicial.add(new Bateria(rs.getInt(1), rs.getInt(2),rs.getInt(3),rs.getInt(4),
													  rs.getString(5),rs.getString(6),rs.getString(7),
					                                  rs.getString(8),rs.getString(9),rs.getString(10),rs.getString(11),
					                                  rs.getString(12),rs.getString(13)));	
		}
		return listBateriaInicial;
	}
	
	
	
	public List<Bateria> getBateriaInicial2(Integer codProva) throws SQLException {
		
		PreparedStatement ps = c.prepareStatement("SELECT codigo,codigo_tb,codigo_prova,codigo_atleta, nome,pais_coi,marca01,marca02,marca03,marca04,marca05,marca06,resultado FROM bateria_inicial WHERE codigo_prova='"+codProva+"'");
		ResultSet rs= ps.executeQuery();
		List<Bateria>listBateriaInicial = new ArrayList<>();
		while(rs.next()){
			listBateriaInicial.add(new Bateria(rs.getInt(1), rs.getInt(2),rs.getInt(3),rs.getInt(4),
													  rs.getString(5),rs.getString(6),rs.getString(7),
					                                  rs.getString(8),rs.getString(9),rs.getString(10),rs.getString(11),
					                                  rs.getString(12),rs.getString(13)));	
		}
		return listBateriaInicial;
	}
	
	
	
	public List<Bateria> getBateriaFinal(Integer codProva) throws SQLException {
		
		if(codProva<7) {
			PreparedStatement ps = c.prepareStatement("INSERT INTO bateria_final SELECT * FROM fn_bateria_final("+codProva+") order by resultado desc");
			ps.execute();
		}
		
		if(codProva>6 && codProva<17) {
			PreparedStatement ps = c.prepareStatement("INSERT INTO bateria_final SELECT * FROM fn_bateria_final("+codProva+") order by resultado asc");
			ps.execute();
		}
		
		PreparedStatement ps = c.prepareStatement("SELECT codigo,codigo_tb,codigo_prova,codigo_atleta, nome,pais_coi,marca01,marca02,marca03,marca04,marca05,marca06,resultado FROM bateria_final WHERE codigo_prova='"+codProva+"'");
		ResultSet rs= ps.executeQuery();
		List<Bateria>listBateriaFinal = new ArrayList<>();
		while(rs.next()){
			listBateriaFinal.add(new Bateria(rs.getInt(1), rs.getInt(2),rs.getInt(3),rs.getInt(4),
													  rs.getString(5),rs.getString(6),rs.getString(7),
					                                  rs.getString(8),rs.getString(9),rs.getString(10),rs.getString(11),
					                                  rs.getString(12),rs.getString(13)));	
		}
		return listBateriaFinal;
	}
	
	
	
	public List<Bateria> getBateriaFinal2(Integer codProva) throws SQLException {
		
		PreparedStatement ps = c.prepareStatement("SELECT codigo,codigo_tb,codigo_prova,codigo_atleta, nome,pais_coi,marca01,marca02,marca03,marca04,marca05,marca06,resultado FROM bateria_final WHERE codigo_prova='"+codProva+"'");
		ResultSet rs= ps.executeQuery();
		List<Bateria>listBateriaFinal = new ArrayList<>();
		while(rs.next()){
			listBateriaFinal.add(new Bateria(rs.getInt(1), rs.getInt(2),rs.getInt(3),rs.getInt(4),
													  rs.getString(5),rs.getString(6),rs.getString(7),
					                                  rs.getString(8),rs.getString(9),rs.getString(10),rs.getString(11),
					                                  rs.getString(12),rs.getString(13)));	
		}
		return listBateriaFinal;
	}
	
}















