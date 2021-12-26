import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;

public class App {

    public static void main(String[] args) throws Exception {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("connecting");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/atguigudb?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true",
                    "root", "123456");
            System.out.println(conn);
        } catch (Exception e) {
            System.err.println(e);
        }
        String sql = "SELECT last_name, first_name FROM employees WHERE employee_id % 2 = 0";
        ResultSet resultSet = null;
        if (conn != null) {
            resultSet = conn.prepareStatement(sql).executeQuery();
        }
        if (resultSet != null) {
            while (resultSet.next()) {
                String last_name = resultSet.getString(1);
                String first_name = resultSet.getString(2);
                System.out.println(last_name + "," + first_name);
                System.out.println("test");
                System.out.println("   ");
            }
        }
    }
}
