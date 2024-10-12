package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Produto;
import service.ICRUD;
import conexao.ConexaoMySQL;

public class ProdutoDAO implements ICRUD<Produto> {

    @Override
    public void create(Produto produto) {
        String sql = "INSERT INTO tbProdutos (nome, descricao, preco, estoque) VALUES (?, ?, ?, ?)";

        try (Connection conn = ConexaoMySQL.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, produto.getNome());
            stmt.setString(2, produto.getDescricao());
            stmt.setDouble(3, produto.getPreco());
            stmt.setInt(4, produto.getEstoque());

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public Produto read(int id) {
        Produto produto = null;
        String sql = "SELECT * FROM tbProdutos WHERE id = ?";

        try (Connection conn = ConexaoMySQL.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                produto = new Produto();
                produto.setId(rs.getInt("id"));
                produto.setNome(rs.getString("nome"));
                produto.setDescricao(rs.getString("descricao"));
                produto.setPreco(rs.getDouble("preco"));
                produto.setEstoque(rs.getInt("estoque"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return produto;
    }

    @Override
    public void update(Produto produto) {
        String sql = "UPDATE tbProdutos SET nome = ?, descricao = ?, preco = ?, estoque = ? WHERE id = ?";

        try (Connection conn = ConexaoMySQL.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, produto.getNome());
            stmt.setString(2, produto.getDescricao());
            stmt.setDouble(3, produto.getPreco());
            stmt.setInt(4, produto.getEstoque());
            stmt.setInt(5, produto.getId());

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void delete(int id) {
        String sql = "DELETE FROM tbProdutos WHERE id = ?";

        try (Connection conn = ConexaoMySQL.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<Produto> getAll() {
        List<Produto> produtos = new ArrayList<>();
        String sql = "SELECT * FROM tbProdutos";

        try (Connection conn = ConexaoMySQL.getConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Produto produto = new Produto();
                produto.setId(rs.getInt("id"));
                produto.setNome(rs.getString("nome"));
                produto.setDescricao(rs.getString("descricao"));
                produto.setPreco(rs.getDouble("preco"));
                produto.setEstoque(rs.getInt("estoque"));
                produtos.add(produto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return produtos;
    }
}
