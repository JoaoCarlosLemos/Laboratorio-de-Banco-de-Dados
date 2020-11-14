package model;

public class Pais {
	
	private String codigo;
	private String pais;
	private int atletas;
	
	public Pais(String codigo, String pais, int atletas) {
		super();
		this.codigo = codigo;
		this.pais = pais;
		this.atletas = atletas;
	}

	public String getCodigo() {
		return codigo;
	}

	public void setCodigo(String codigo) {
		this.codigo = codigo;
	}

	public String getPais() {
		return pais;
	}

	public void setPais(String pais) {
		this.pais = pais;
	}

	public int getAtletas() {
		return atletas;
	}

	public void setAtletas(int atletas) {
		this.atletas = atletas;
	}
}
