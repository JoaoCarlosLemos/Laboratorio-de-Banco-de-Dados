package persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.ApuracaoPorQuesito;
import model.EscolaDeSamba;
import model.Parcial;


public class ParcialDao {
	
private Connection c;
	
	public ParcialDao() throws ClassNotFoundException, SQLException {
		GenericDao gDao = new GenericDao();
		c = gDao.getConnection();
	}
	
	public void chamadaProcedure(Parcial a) throws SQLException {
		String sql = "{CALL sp_apuracao(?,?,?,?)}";
		CallableStatement cs = c.prepareCall(sql);
		cs.setInt(1, a.getIdJurado());
		cs.setInt(2, a.getIdEscola());
		cs.setInt(3, a.getIdQuesito());
		cs.setDouble(4, a.getNota());
		
		cs.execute();
		cs.close();
	
	}
	
	public List<ApuracaoPorQuesito> getAPQs (Parcial a) throws SQLException{
		PreparedStatement ps = c.prepareStatement("SELECT  Escola_de_Samba.nome AS Escola,Apuracao.nota_1,Apuracao.nota_2,Apuracao.nota_3,Apuracao.nota_4,Apuracao.nota_5,\r\n" + 
				"		Apuracao.menor,Apuracao.maior,Apuracao.total FROM Apuracao\r\n" + 
				"INNER JOIN  Jurados			ON Jurados.id = Apuracao.id_jurado\r\n" + 
				"INNER JOIN Escola_de_Samba	ON Apuracao.id_escola = Escola_de_Samba.id\r\n" + 
				"INNER JOIN Quesito			ON Apuracao.id_quesito = Quesito.id\r\n" + 
				"WHERE Quesito.id='"+a.getIdQuesito()+"' \r\n" + 
				"ORDER BY Escola_de_Samba.nome");
		
	
		
		ResultSet rs= ps.executeQuery();
		List<ApuracaoPorQuesito>listAPQs = new ArrayList<>();
		while(rs.next()){
			listAPQs.add(new ApuracaoPorQuesito(rs.getString(1), rs.getDouble(2), rs.getDouble(3), 
			rs.getDouble(4),rs.getDouble(5), rs.getDouble(6), rs.getDouble(7),rs.getDouble(8),rs.getDouble(9)));	
		}
		return listAPQs;
	}

	public List<EscolaDeSamba> getEDSs() throws SQLException {
		PreparedStatement ps = c.prepareStatement("SELECT  Escola_de_Samba.nome AS Escola,Escola_de_Samba.total_pontos AS Total FROM Escola_de_Samba\r\n" + 
				"ORDER BY  Escola_de_Samba.total_pontos DESC");
		
		ResultSet rs= ps.executeQuery();
		List<EscolaDeSamba>listEDS = new ArrayList<>();
		while(rs.next()){
			listEDS.add(new EscolaDeSamba(rs.getString(1), rs.getDouble(2)));	
		}
		return listEDS;
	}

}















