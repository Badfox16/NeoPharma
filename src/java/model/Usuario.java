package model;

public class Usuario {
    private int idUser;
    private String nome;
    private String apelido;
    private String telefone;
    private String username;
    private String senha;

    // Construtores, getters e setters
    public Usuario() {}

    public Usuario(int idUser, String nome, String apelido, String telefone, String username, String senha) {
        this.idUser = idUser;
        this.nome = nome;
        this.apelido = apelido;
        this.telefone = telefone;
        this.username = username;
        this.senha = senha;
    }

    public int getIdUser() { return idUser; }
    public void setIdUser(int idUser) { this.idUser = idUser; }
    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }
    public String getApelido() { return apelido; }
    public void setApelido(String apelido) { this.apelido = apelido; }
    public String getTelefone() { return telefone; }
    public void setTelefone(String telefone) { this.telefone = telefone; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getSenha() { return senha; }
    public void setSenha(String senha) { this.senha = senha; }
}
