import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;

public class App {
    private static ResultSet executeQuery;

    public static void main(String[] args) throws Exception {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("connecting");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/atguigudb?useSSL=false&serverTimezone=UTC",
                    "root", "123456");
            System.out.println(conn);
        } catch (Exception e) {
            System.err.println(e);
        }
        String sql = "SELECT last_name, first_name FROM employees WHERE employee_id % 2 = 0";
        executeQuery = conn.prepareStatement(sql).executeQuery();
        while (executeQuery.next()) {
            String last_name = executeQuery.getString(1);
            String first_name = executeQuery.getString(2);
            System.out.println(last_name + "," + first_name);
        }
    }
}
