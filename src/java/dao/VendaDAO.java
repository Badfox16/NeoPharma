package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Venda;
import service.ICRUD;
import conexao.ConexaoMySQL;

public class VendaDAO implements ICRUD<Venda> {

    @Override
    public void create(Venda venda) {
        String sql = "INSERT INTO tbVendas (id_usuario, data_venda, total) VALUES (?, ?, ?)";

        try (Connection conn = ConexaoMySQL.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, venda.getIdUsuario());
            stmt.setTimestamp(2, Timestamp.valueOf(venda.getDataVenda()));
            stmt.setBigDecimal(3, venda.getTotal());

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public Venda read(int id) {
        Venda venda = null;
        String sql = "SELECT * FROM tbVendas WHERE id = ?";

        try (Connection conn = ConexaoMySQL.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                venda = new Venda();
                venda.setId(rs.getInt("id"));
                venda.setIdUsuario(rs.getInt("id_usuario"));
                venda.setDataVenda(rs.getTimestamp("data_venda").toLocalDateTime());
                venda.setTotal(rs.getBigDecimal("total"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return venda;
    }

    @Override
    public void update(Venda venda) {
        String sql = "UPDATE tbVendas SET id_usuario = ?, data_venda = ?, total = ? WHERE id = ?";

        try (Connection conn = ConexaoMySQL.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, venda.getIdUsuario());
            stmt.setTimestamp(2, Timestamp.valueOf(venda.getDataVenda()));
            stmt.setBigDecimal(3, venda.getTotal());
            stmt.setInt(4, venda.getId());

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void delete(int id) {
        String sql = "DELETE FROM tbVendas WHERE id = ?";

        try (Connection conn = ConexaoMySQL.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<Venda> getAll() {
        List<Venda> vendas = new ArrayList<>();
        String sql = "SELECT * FROM tbVendas";

        try (Connection conn = ConexaoMySQL.getConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Venda venda = new Venda();
                venda.setId(rs.getInt("id"));
                venda.setIdUsuario(rs.getInt("id_usuario"));
                venda.setDataVenda(rs.getTimestamp("data_venda").toLocalDateTime());
                venda.setTotal(rs.getBigDecimal("total"));
                vendas.add(venda);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return vendas;
    }
}
