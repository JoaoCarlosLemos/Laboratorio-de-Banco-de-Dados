package persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Prova;


public class ProvaDao {
	
private Connection c;
	
	public ProvaDao() throws ClassNotFoundException, SQLException {
		GenericDao gDao = new GenericDao();
		c = gDao.getConnection();
	}
	

	public List<Prova> getProvas() throws SQLException {
		PreparedStatement ps = c.prepareStatement("SELECT codigo_prova,horario,descricao,genero FROM prova ORDER BY  horario ASC");
		ResultSet rs= ps.executeQuery();
		List<Prova>listProvas = new ArrayList<>();
		while(rs.next()){
			listProvas.add(new Prova(rs.getInt(1), rs.getString(2),rs.getString(3),rs.getString(4)));	
		}
		return listProvas;
	}

}















