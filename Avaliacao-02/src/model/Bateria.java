package model;

public class Bateria {
	
	
	private int codigo;
	private int codigo_tb;
	private int codigo_prova;
	private int codigo_atleta;
	private String nome;
	private String pais_coi;
	private String marca01;
	private String marca02;
	private String marca03;
	private String marca04;
	private String marca05;
	private String marca06;
	private String resultado;
	
	public Bateria(int codigo, int codigo_tb, int codigo_prova, int codigo_atleta, String nome, String pais_coi,
			String marca01, String marca02, String marca03, String marca04, String marca05, String marca06,
			String resultado) {
		super();
		this.codigo = codigo;
		this.codigo_tb = codigo_tb;
		this.codigo_prova = codigo_prova;
		this.codigo_atleta = codigo_atleta;
		this.nome = nome;
		this.pais_coi = pais_coi;
		this.marca01 = marca01;
		this.marca02 = marca02;
		this.marca03 = marca03;
		this.marca04 = marca04;
		this.marca05 = marca05;
		this.marca06 = marca06;
		this.resultado = resultado;
	}

	public int getCodigo() {
		return codigo;
	}

	public void setCodigo(int codigo) {
		this.codigo = codigo;
	}

	public int getCodigo_tb() {
		return codigo_tb;
	}

	public void setCodigo_tb(int codigo_tb) {
		this.codigo_tb = codigo_tb;
	}

	public int getCodigo_prova() {
		return codigo_prova;
	}

	public void setCodigo_prova(int codigo_prova) {
		this.codigo_prova = codigo_prova;
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

	public String getPais_coi() {
		return pais_coi;
	}

	public void setPais_coi(String pais_coi) {
		this.pais_coi = pais_coi;
	}

	public String getMarca01() {
		return marca01;
	}

	public void setMarca01(String marca01) {
		this.marca01 = marca01;
	}

	public String getMarca02() {
		return marca02;
	}

	public void setMarca02(String marca02) {
		this.marca02 = marca02;
	}

	public String getMarca03() {
		return marca03;
	}

	public void setMarca03(String marca03) {
		this.marca03 = marca03;
	}

	public String getMarca04() {
		return marca04;
	}

	public void setMarca04(String marca04) {
		this.marca04 = marca04;
	}

	public String getMarca05() {
		return marca05;
	}

	public void setMarca05(String marca05) {
		this.marca05 = marca05;
	}

	public String getMarca06() {
		return marca06;
	}

	public void setMarca06(String marca06) {
		this.marca06 = marca06;
	}

	public String getResultado() {
		return resultado;
	}

	public void setResultado(String resultado) {
		this.resultado = resultado;
	}
	
}
