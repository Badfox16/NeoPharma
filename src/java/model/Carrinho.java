package model;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class Carrinho {
    private List<ItemVenda> itens;

    public Carrinho() {
        this.itens = new ArrayList<>();
    }

    public void adicionarItem(ItemVenda item) {
        this.itens.add(item);
    }

    public void removerItem(int idProduto) {
        this.itens.removeIf(item -> item.getIdProduto() == idProduto);
    }

    public List<ItemVenda> getItens() {
        return itens;
    }

    public BigDecimal getTotal() {
        return itens.stream()
                .map(item -> item.getPrecoUnitario().multiply(new BigDecimal(item.getQuantidade())))
                .reduce(BigDecimal.ZERO, BigDecimal::add);
    }
}