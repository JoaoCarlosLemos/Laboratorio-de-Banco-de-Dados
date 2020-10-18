package model;

public class EscolaDeSamba {
	
	private int id;
	private String nome;
	private double total_pontos;
	
	
	
	
	public EscolaDeSamba(String nome, double total_pontos) {
		super();
		this.nome = nome;
		this.total_pontos = total_pontos;
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public double getTotal_pontos() {
		return total_pontos;
	}
	public void setTotal_pontos(double total_pontos) {
		this.total_pontos = total_pontos;
	}
	
	

}
