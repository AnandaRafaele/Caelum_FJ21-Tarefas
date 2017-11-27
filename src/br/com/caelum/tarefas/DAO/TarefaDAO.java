package br.com.caelum.tarefas.DAO;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import br.com.caelum.tarefas.modelo.Tarefa;

@Repository
public class TarefaDAO {

	private Connection conexao;

	@Autowired
	public TarefaDAO(DataSource dataSource) {
		
		try {
			this.conexao = dataSource.getConnection();
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	public void adiciona(Tarefa tarefa) {

		String sql = "INSERT INTO tarefas (descricao) VALUES (?)";

		try {
			PreparedStatement stmt = conexao.prepareStatement(sql);

			stmt.setString(1, tarefa.getDescricao());
			// stmt.setBoolean(2, tarefa.isFinalizado());
			// stmt.setDate(3, new Date(tarefa.getDataFinalizacao().getTimeInMillis()));

			stmt.execute();
			stmt.close();
			System.out.println("Adicionando Tarefa");
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	public List<Tarefa> lista() {
		String sql = "SELECT * FROM tarefas ORDER BY id";

		List<Tarefa> tarefas = new ArrayList<Tarefa>();

		try {

			PreparedStatement stmt = conexao.prepareStatement(sql);
			ResultSet rs = stmt.executeQuery();

			while (rs.next()) {
				// criando o objeto Contato
				Tarefa tarefa = new Tarefa();
				tarefa.setId(rs.getLong("id"));
				tarefa.setDescricao(rs.getString("descricao"));
				tarefa.setFinalizado(rs.getBoolean("finalizado"));

				// montando a data através do Calendar
				Calendar data = Calendar.getInstance();

				if (rs.getDate("dataFinalizacao") != null) {
					data.setTime(rs.getDate("dataFinalizacao"));
					tarefa.setDataFinalizacao(data);
				} else {
					tarefa.setDataFinalizacao(null);
				}

				// adicionando o objeto à lista
				tarefas.add(tarefa);
			}

			rs.close();
			stmt.close();
			System.out.println("Listando Tarefa");
			return tarefas;

		} catch (SQLException e) {
			throw new RuntimeException(e);
		}

	}

	public void remover(Tarefa tarefa) {

		String sql = "DELETE FROM tarefas WHERE id = ?";

		try {
			PreparedStatement stmt = conexao.prepareStatement(sql);
			stmt.setLong(1, tarefa.getId());

			stmt.execute();
			stmt.close();
			System.out.println("Removendo Tarefa");

		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	public Tarefa buscaPorId(Long id) {
		String sql = "SELECT id,descricao,finalizado, dataFinalizacao FROM tarefas WHERE id = ?";

		try {
			PreparedStatement stmt = conexao.prepareStatement(sql);

			stmt.setLong(1, id);

			ResultSet rs = stmt.executeQuery();

			Tarefa tarefa = new Tarefa();

			// montando a data através do Calendar
			Calendar data = Calendar.getInstance();

			while (rs.next()) {
				tarefa.setId(rs.getLong("id"));
				tarefa.setDescricao(rs.getString("descricao"));
				tarefa.setFinalizado(rs.getBoolean("finalizado"));

				if (rs.getDate("dataFinalizacao") != null) {
					data.setTime(rs.getDate("dataFinalizacao"));
					tarefa.setDataFinalizacao(data);
				} else {
					tarefa.setDataFinalizacao(null);
				}
			}

			rs.close();
			stmt.close();
			System.out.println("Mostrando Tarefa");
			return tarefa;

		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	public void alterar(Tarefa tarefa) {
		String sql = "UPDATE tarefas SET descricao = ?, finalizado = ?, dataFinalizacao = ? WHERE id = ?";

		try {

			PreparedStatement stmt = conexao.prepareStatement(sql);

			stmt.setString(1, tarefa.getDescricao());
			stmt.setBoolean(2, tarefa.isFinalizado());
			stmt.setDate(3, new Date(tarefa.getDataFinalizacao().getTimeInMillis()));
			stmt.setLong(4, tarefa.getId());

			stmt.execute();
			stmt.close();
			System.out.println("Alterando Tarefa");
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	public void finaliza(Long id) {

		if (id == null) {
			throw new IllegalStateException("Id da tarefa não deve ser nula.");
		}

		String sql = "UPDATE tarefas SET finalizado = ?, dataFinalizacao = ? WHERE id = ?";

		try {
			PreparedStatement stmt = conexao.prepareStatement(sql);
			stmt.setBoolean(1, true);
			stmt.setDate(2, new Date(Calendar.getInstance().getTimeInMillis()));
			stmt.setLong(3, id);

			stmt.execute();
			stmt.close();
			System.out.println("Finalizando Tarefa");
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
}
