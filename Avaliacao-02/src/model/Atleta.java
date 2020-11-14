package model;

public class Atleta {
	
	private int codigo_atleta;
	private String nome;
	private String sexo;
	private String codigo_coi;
	private String pais_coi;
	private String descricao;
	
	public Atleta(int codigo_atleta, String nome, String sexo, String codigo_coi, String pais_coi, String descricao) {
		super();
		this.codigo_atleta = codigo_atleta;
		this.nome = nome;
		this.sexo = sexo;
		this.codigo_coi = codigo_coi;
		this.pais_coi = pais_coi;
		this.descricao = descricao;
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

	public String getSexo() {
		return sexo;
	}

	public void setSexo(String sexo) {
		this.sexo = sexo;
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

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}
}
