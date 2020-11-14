package model;

public class ParticipantesProva {
	
	private int codigo_atleta;
	private String nome;
	private String codigo_coi;
	private String pais_coi;
	
	public ParticipantesProva(int codigo_atleta, String nome, String codigo_coi, String pais_coi) {
		super();
		this.codigo_atleta = codigo_atleta;
		this.nome = nome;
		this.codigo_coi = codigo_coi;
		this.pais_coi = pais_coi;
	}

	public int getCodigo_atleta() {
		return codigo_atleta;
	}

	public void setCodigo_atleta(int codigo_atleta) {
		this.codigo_atleta = codigo_atleta;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getCodigo_coi() {
		return codigo_coi;
	}

	public void setCodigo_coi(String codigo_coi) {
		this.codigo_coi = codigo_coi;
	}

	public String getPais_coi() {
		return pais_coi;
	}

	public void setPais_coi(String pais_coi) {
		this.pais_coi = pais_coi;
	}
}
