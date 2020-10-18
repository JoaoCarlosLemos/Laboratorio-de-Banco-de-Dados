package model;

public class ApuracaoPorQuesito {
	
	private String escola;
	private double nota1;
	private double nota2;
	private double nota3;
	private double nota4;
	private double nota5;
	private double menor;
	private double maior;
	private double total;
	
	
	
	public ApuracaoPorQuesito(String escola, double nota1, double nota2, double nota3, double nota4, double nota5,
			double menor,double maior,double total) {
		super();
		this.escola = escola;
		this.nota1 = nota1;
		this.nota2 = nota2;
		this.nota3 = nota3;
		this.nota4 = nota4;
		this.nota5 = nota5;
		this.menor = menor;
		this.maior = maior;
		this.total = total;
	}
	

	public String getEscola() {
		return escola;
	}
	public void setEscola(String escola) {
		this.escola = escola;
	}
	public double getNota1() {
		return nota1;
	}
	public void setNota1(double nota1) {
		this.nota1 = nota1;
	}
	public double getNota2() {
		return nota2;
	}
	public void setNota2(double nota2) {
		this.nota2 = nota2;
	}
	public double getNota3() {
		return nota3;
	}
	public void setNota3(double nota3) {
		this.nota3 = nota3;
	}
	public double getNota4() {
		return nota4;
	}
	public void setNota4(double nota4) {
		this.nota4 = nota4;
	}
	public double getNota5() {
		return nota5;
	}
	public void setNota5(double nota5) {
		this.nota5 = nota5;
	}
	public double getMenor() {
		return menor;
	}
	public void setMenor(double menor) {
		this.menor = menor;
	}
	public double getMaior() {
		return maior;
	}
	public void setMaior(double maior) {
		this.maior = maior;
	}
	public double getTotal() {
		return total;
	}
	public void setTotal(double total) {
		this.total = total;
	}
}
