package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Usuario;
import service.ICRUD;
import conexao.ConexaoMySQL;

public class UsuarioDAO implements ICRUD<Usuario> {

    @Override
    public void create(Usuario usuario) {
        String sql = "INSERT INTO tbUsuarios (Nome, Apelido, Telefone, Username, Senha) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = ConexaoMySQL.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, usuario.getNome());
            stmt.setString(2, usuario.getApelido());
            stmt.setString(3, usuario.getTelefone());
            stmt.setString(4, usuario.getUsername());
            stmt.setString(5, usuario.getSenha());

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public Usuario read(int id) {
        Usuario usuario = null;
        String sql = "SELECT * FROM tbUsuarios WHERE IDUser = ?";

        try (Connection conn = ConexaoMySQL.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                usuario = new Usuario();
                usuario.setIdUser(rs.getInt("IDUser"));
                usuario.setNome(rs.getString("Nome"));
                usuario.setApelido(rs.getString("Apelido"));
                usuario.setTelefone(rs.getString("Telefone"));
                usuario.setUsername(rs.getString("Username"));
                usuario.setSenha(rs.getString("Senha"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return usuario;
    }

    @Override
    public void update(Usuario usuario) {
        String sql = "UPDATE tbUsuarios SET Nome = ?, Apelido = ?, Telefone = ?, Username = ?, Senha = ? WHERE IDUser = ?";

        try (Connection conn = ConexaoMySQL.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, usuario.getNome());
            stmt.setString(2, usuario.getApelido());
            stmt.setString(3, usuario.getTelefone());
            stmt.setString(4, usuario.getUsername());
            stmt.setString(5, usuario.getSenha());
            stmt.setInt(6, usuario.getIdUser());

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void delete(int id) {
        String sql = "DELETE FROM tbUsuarios WHERE IDUser = ?";

        try (Connection conn = ConexaoMySQL.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<Usuario> getAll() {
        List<Usuario> usuarios = new ArrayList<>();
        String sql = "SELECT * FROM tbUsuarios";

        try (Connection conn = ConexaoMySQL.getConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Usuario usuario = new Usuario();
                usuario.setIdUser(rs.getInt("IDUser"));
                usuario.setNome(rs.getString("Nome"));
                usuario.setApelido(rs.getString("Apelido"));
                usuario.setTelefone(rs.getString("Telefone"));
                usuario.setUsername(rs.getString("Username"));
                usuario.setSenha(rs.getString("Senha"));
                usuarios.add(usuario);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return usuarios;
    }

    // Método de login
    public Usuario login(String username, String senha) {
        String sql = "SELECT * FROM tbUsuarios WHERE username = ? AND senha = ?";

        try (Connection conn = ConexaoMySQL.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            // Definir os parâmetros
            stmt.setString(1, username);
            stmt.setString(2, senha);

            // Executar a consulta
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    // Se encontrar o usuário, criar o objeto Usuario
                    Usuario usuario = new Usuario();
                    usuario.setIdUser(rs.getInt("idUser"));
                    usuario.setNome(rs.getString("nome"));
                    usuario.setApelido(rs.getString("apelido"));
                    usuario.setTelefone(rs.getString("telefone"));
                    usuario.setUsername(rs.getString("username"));
                    // usuario.setSenha(rs.getString("senha"));
                    return usuario; // Login bem-sucedido
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null; // Login falhou
    }
}
