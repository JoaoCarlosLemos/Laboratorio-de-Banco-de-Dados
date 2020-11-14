package persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import model.ParticipantesProva;


public class ParticipantesProvaDao {
	
private Connection c;
	
	public ParticipantesProvaDao() throws ClassNotFoundException, SQLException {
		GenericDao gDao = new GenericDao();
		c = gDao.getConnection();
	}
	

	public List<ParticipantesProva> getParticipantesProva(Integer codProva) throws SQLException {
		PreparedStatement ps = c.prepareStatement("SELECT atleta.codigo_atleta,atleta.nome,atleta.codigo_coi,"
				+ "coi.pais_coi FROM atleta INNER JOIN  coi	ON atleta.codigo_coi = coi.codigo_coi "
				+ "WHERE atleta.codigo_prova='"+codProva+"'");
		ResultSet rs= ps.executeQuery();
		List<ParticipantesProva>listParticipantesProva = new ArrayList<>();
		while(rs.next()){
			listParticipantesProva.add(new ParticipantesProva(rs.getInt(1), rs.getString(2),rs.getString(3),
					                                          rs.getString(4)));	
		}
		return listParticipantesProva;
	}


	public String chamadaProcedure(Integer codigoProva) throws SQLException {
		
		String sql = "{CALL sp_descricao_prova(?,?)}";
		CallableStatement cs = c.prepareCall(sql);
		cs.setInt(1, codigoProva);
		cs.registerOutParameter(2,Types.VARCHAR);
		cs.execute();
		String retorno= cs.getString(2);
		cs.close();
		return retorno;
	}


	public String chamadaProcedureRecordeGp(Integer codigoProva)throws SQLException {
		String sql = "{CALL sp_recorde_gp(?,?)}";
		CallableStatement cs = c.prepareCall(sql);
		cs.setInt(1, codigoProva);
		cs.registerOutParameter(2,Types.VARCHAR);
		cs.execute();
		String retorno= cs.getString(2);
		cs.close();
		return retorno;
	}


	public String chamadaProcedureRecordeMundial(Integer codigoProva)throws SQLException {
		String sql = "{CALL sp_recorde_mundial(?,?)}";
		CallableStatement cs = c.prepareCall(sql);
		cs.setInt(1, codigoProva);
		cs.registerOutParameter(2,Types.VARCHAR);
		cs.execute();
		String retorno= cs.getString(2);
		cs.close();
		return retorno;
	}

	
	



}















