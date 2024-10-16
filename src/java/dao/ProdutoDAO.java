package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Farmaco;
import service.ICRUD;
import conexao.ConexaoMySQL;

public class ProdutoDAO implements ICRUD<Farmaco> {

    @Override
    public void create(Farmaco produto) {
        String sql = "INSERT INTO tbFarmacos (nome, descricao, preco, estoque, dosagem, id_tipo) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = ConexaoMySQL.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, produto.getNome());
            stmt.setString(2, produto.getDescricao());
            stmt.setDouble(3, produto.getPreco());
            stmt.setInt(4, produto.getEstoque());
            stmt.setString(5, produto.getDosagem());
            stmt.setString(6, produto.getIdTipo());

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public Farmaco read(int id) {
        Farmaco produto = null;
        String sql = "SELECT * FROM tbFarmacos WHERE id = ?";

        try (Connection conn = ConexaoMySQL.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                produto = new Farmaco();
                produto.setId(rs.getInt("id"));
                produto.setNome(rs.getString("nome"));
                produto.setDescricao(rs.getString("descricao"));
                produto.setPreco(rs.getDouble("preco"));
                produto.setEstoque(rs.getInt("estoque"));
                produto.setDosagem(rs.getString("dosagem"));
                produto.setIdTipo(rs.getString("id_tipo"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return produto;
    }

    @Override
    public void update(Farmaco produto) {
        String sql = "UPDATE tbFarmacos SET nome = ?, descricao = ?, preco = ?, estoque = ?, dosagem = ?, id_tipo = ? WHERE id = ?";

        try (Connection conn = ConexaoMySQL.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, produto.getNome());
            stmt.setString(2, produto.getDescricao());
            stmt.setDouble(3, produto.getPreco());
            stmt.setInt(4, produto.getEstoque());
            stmt.setString(5, produto.getDosagem());
            stmt.setString(6, produto.getIdTipo());
            stmt.setInt(7, produto.getId());

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void delete(int id) {
        String sql = "DELETE FROM tbFarmacos WHERE id = ?";

        try (Connection conn = ConexaoMySQL.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<Farmaco> getAll() {
        List<Farmaco> Farmacos = new ArrayList<>();
        String sql = "SELECT * FROM tbFarmacos";

        try (Connection conn = ConexaoMySQL.getConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Farmaco produto = new Farmaco();
                produto.setId(rs.getInt("id"));
                produto.setNome(rs.getString("nome"));
                produto.setDescricao(rs.getString("descricao"));
                produto.setPreco(rs.getDouble("preco"));
                produto.setEstoque(rs.getInt("estoque"));
                produto.setDosagem(rs.getString("dosagem"));
                produto.setIdTipo(rs.getString("id_tipo"));
                Farmacos.add(produto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Farmacos;
    }

    public List<Farmaco> getAllEmStock() {
        List<Farmaco> Farmacos = new ArrayList<>();
        String sql = "SELECT * FROM tbFarmacos WHERE estoque > 0";

        try (Connection conn = ConexaoMySQL.getConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Farmaco produto = new Farmaco();
                produto.setId(rs.getInt("id"));
                produto.setNome(rs.getString("nome"));
                produto.setDescricao(rs.getString("descricao"));
                produto.setPreco(rs.getDouble("preco"));
                produto.setEstoque(rs.getInt("estoque"));
                produto.setDosagem(rs.getString("dosagem"));
                produto.setIdTipo(rs.getString("id_tipo"));
                Farmacos.add(produto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Farmacos;
    }
}
