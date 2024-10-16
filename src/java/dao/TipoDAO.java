package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Tipo;
import service.ICRUD;
import conexao.ConexaoMySQL;

public class TipoDAO implements ICRUD<Tipo> {

    @Override
    public void create(Tipo Tipo) {
        String sql = "INSERT INTO tbTipos (tipo) VALUES (?)";

        try (Connection conn = ConexaoMySQL.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, Tipo.getTipo());

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public Tipo read(int id) {
        Tipo Tipo = null;
        String sql = "SELECT * FROM tbTipos WHERE id = ?";

        try (Connection conn = ConexaoMySQL.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Tipo = new Tipo();
                Tipo.setId(rs.getInt("id"));
                Tipo.setTipo(rs.getString("tipo"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Tipo;
    }

    @Override
    public void update(Tipo Tipo) {
        String sql = "UPDATE tbTipos SET tipo = ? WHERE id = ?";

        try (Connection conn = ConexaoMySQL.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, Tipo.getTipo());
            stmt.setInt(2, Tipo.getId());

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void delete(int id) {
        String sql = "DELETE FROM tbTipos WHERE id = ?";

        try (Connection conn = ConexaoMySQL.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<Tipo> getAll() {
        List<Tipo> Tipos = new ArrayList<>();
        String sql = "SELECT * FROM tbTipos";

        try (Connection conn = ConexaoMySQL.getConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Tipo Tipo = new Tipo();
                Tipo.setId(rs.getInt("id"));
                Tipo.setTipo(rs.getString("tipo"));
                Tipos.add(Tipo);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Tipos;
    }
}
