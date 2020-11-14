package model;

public class Prova {
	
	private int codigo_prova;
	private String horario;
	private String descricao;
	private String genero;
	
	public Prova(int codigo_prova, String horario, String descricao, String genero) {
		this.codigo_prova = codigo_prova;
		this.horario = horario;
		this.descricao = descricao;
		this.genero = genero;
	}
	
	public int getCodigo_prova() {
		return codigo_prova;
	}
	public void setCodigo_prova(int codigo_prova) {
		this.codigo_prova = codigo_prova;
	}
	public String getHorario() {
		return horario;
	}
	public void setHorario(String horario) {
		this.horario = horario;
	}
	public String getDescricao() {
		return descricao;
	}
	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}
	public String getGenero() {
		return genero;
	}
	public void setGenero(String genero) {
		this.genero = genero;
	}	
}

