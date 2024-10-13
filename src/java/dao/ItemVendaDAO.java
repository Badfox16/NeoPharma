package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.ItemVenda;
import service.ICRUD;
import conexao.ConexaoMySQL;

public class ItemVendaDAO implements ICRUD<ItemVenda> {

    @Override
    public void create(ItemVenda itemVenda) {
        String sql = "INSERT INTO tbItensVenda (id_venda, id_produto, quantidade, preco_unitario) VALUES (?, ?, ?, ?)";

        try (Connection conn = ConexaoMySQL.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, itemVenda.getIdVenda());
            stmt.setInt(2, itemVenda.getIdProduto());
            stmt.setInt(3, itemVenda.getQuantidade());
            stmt.setBigDecimal(4, itemVenda.getPrecoUnitario());

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public ItemVenda read(int id) {
        ItemVenda itemVenda = null;
        String sql = "SELECT * FROM tbItensVenda WHERE id = ?";

        try (Connection conn = ConexaoMySQL.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                itemVenda = new ItemVenda();
                itemVenda.setId(rs.getInt("id"));
                itemVenda.setIdVenda(rs.getInt("id_venda"));
                itemVenda.setIdProduto(rs.getInt("id_produto"));
                itemVenda.setQuantidade(rs.getInt("quantidade"));
                itemVenda.setPrecoUnitario(rs.getBigDecimal("preco_unitario"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return itemVenda;
    }

    public List<ItemVenda> getByVendaId(int id) {
        List<ItemVenda> itensVenda = new ArrayList<>();
        String sql = "SELECT iv.*, p.nome, p.descricao FROM tbItensVenda iv JOIN tbProdutos p ON iv.id_produto = p.id WHERE iv.id_venda = ?";

        try (Connection conn = ConexaoMySQL.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                ItemVenda itemVenda = new ItemVenda();
                itemVenda.setId(rs.getInt("id"));
                itemVenda.setIdVenda(rs.getInt("id_venda"));
                itemVenda.setIdProduto(rs.getInt("id_produto"));
                itemVenda.setQuantidade(rs.getInt("quantidade"));
                itemVenda.setPrecoUnitario(rs.getBigDecimal("preco_unitario"));
                itemVenda.setNomeProduto(rs.getString("nome"));
                itemVenda.setDescricaoProduto(rs.getString("descricao"));
                itensVenda.add(itemVenda);

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return itensVenda;
    }

    @Override
    public void update(ItemVenda itemVenda) {
        String sql = "UPDATE tbItensVenda SET id_venda = ?, id_produto = ?, quantidade = ?, preco_unitario = ? WHERE id = ?";

        try (Connection conn = ConexaoMySQL.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, itemVenda.getIdVenda());
            stmt.setInt(2, itemVenda.getIdProduto());
            stmt.setInt(3, itemVenda.getQuantidade());
            stmt.setBigDecimal(4, itemVenda.getPrecoUnitario());
            stmt.setInt(5, itemVenda.getId());

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void delete(int id) {
        String sql = "DELETE FROM tbItensVenda WHERE id = ?";

        try (Connection conn = ConexaoMySQL.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<ItemVenda> getAll() {
        List<ItemVenda> itensVenda = new ArrayList<>();
        String sql = "SELECT * FROM tbItensVenda ORDER BY id DESC";

        try (Connection conn = ConexaoMySQL.getConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                ItemVenda itemVenda = new ItemVenda();
                itemVenda.setId(rs.getInt("id"));
                itemVenda.setIdVenda(rs.getInt("id_venda"));
                itemVenda.setIdProduto(rs.getInt("id_produto"));
                itemVenda.setQuantidade(rs.getInt("quantidade"));
                itemVenda.setPrecoUnitario(rs.getBigDecimal("preco_unitario"));
                itensVenda.add(itemVenda);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return itensVenda;
    }
}
