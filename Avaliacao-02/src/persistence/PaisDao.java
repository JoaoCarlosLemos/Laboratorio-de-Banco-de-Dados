package persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Pais;


public class PaisDao {
	
private Connection c;
	
	public PaisDao() throws ClassNotFoundException, SQLException {
		GenericDao gDao = new GenericDao();
		c = gDao.getConnection();
	}
	

	public List<Pais> getPaises() throws SQLException {
		PreparedStatement ps = c.prepareStatement("SELECT atleta.codigo_coi AS codigo,coi.pais_coi AS pais, "
				+ "COUNT(atleta.codigo_coi)AS atletas FROM atleta INNER JOIN  coi	"
				+ "ON atleta.codigo_coi = coi.codigo_coi GROUP BY coi.codigo_coi,atleta.codigo_coi,coi.pais_coi");
		ResultSet rs= ps.executeQuery();
		List<Pais>listPaises = new ArrayList<>();
		while(rs.next()){
			listPaises.add(new Pais(rs.getString(1),rs.getString(2),rs.getInt(3)));	
		}
		return listPaises;
	}
}















