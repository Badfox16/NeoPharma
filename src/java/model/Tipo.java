package model;

public class Tipo {
    private int id;
    private String tipo;

    // Construtores, getters e setters
    public Tipo() {}

    public Tipo(int id, String tipo) {
        this.id = id;
        this.tipo = tipo;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTipo() { return tipo; }
    public void setTipo(String tipo) { this.tipo = tipo; }

}
