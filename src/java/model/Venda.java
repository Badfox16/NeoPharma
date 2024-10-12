package model;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public class Venda {
    private int id;
    private int idUsuario;
    private LocalDateTime dataVenda;
    private BigDecimal total;

    public Venda() {
    }

    public Venda(int id, int idUsuario, LocalDateTime dataVenda, BigDecimal total) {
        this.id = id;
        this.idUsuario = idUsuario;
        this.dataVenda = dataVenda;
        this.total = total;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public LocalDateTime getDataVenda() {
        return dataVenda;
    }

    public void setDataVenda(LocalDateTime dataVenda) {
        this.dataVenda = dataVenda;
    }

    public BigDecimal getTotal() {
        return total;
    }

    public void setTotal(BigDecimal total) {
        this.total = total;
    }
}