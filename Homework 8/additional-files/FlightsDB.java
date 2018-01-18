import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;  // TODO: REMOVE THIS


/**
 * Allows clients to query and update the database in order to log in, search
 * for flights, reserve seats, show reservations, and cancel reservations.
 */
public class FlightsDB {

  /** Maximum number of reservations to allow on one flight. */
  private static int MAX_FLIGHT_BOOKINGS = 3;

  /** Holds the connection to the database. */
  private Connection conn;

  /** Opens a connection to the database using the given settings. */
  public void open(Properties settings) throws Exception {
    // Make sure the JDBC driver is loaded.
    String driverClassName = settings.getProperty("flightservice.jdbc_driver");
    Class.forName(driverClassName).newInstance();

    // Open a connection to our database.
    conn = DriverManager.getConnection(
        settings.getProperty("flightservice.url"),
        settings.getProperty("flightservice.sqlazure_username"),
        settings.getProperty("flightservice.sqlazure_password"));
  }

  /** Closes the connection to the database. */
  public void close() throws SQLException {
    conn.close();
    conn = null;
  }

  // SQL statements with spaces left for parameters:
  private PreparedStatement beginTxnStmt;
  private PreparedStatement commitTxnStmt;
  private PreparedStatement abortTxnStmt;

  /** Performs additional preparation after the connection is opened. */
  public void prepare() throws SQLException {
    // NOTE: We must explicitly set the isolation level to SERIALIZABLE as it
    //       defaults to allowing non-repeatable reads.
    beginTxnStmt = conn.prepareStatement(
        "SET TRANSACTION ISOLATION LEVEL SERIALIZABLE; BEGIN TRANSACTION;");
    commitTxnStmt = conn.prepareStatement("COMMIT TRANSACTION");
    abortTxnStmt = conn.prepareStatement("ROLLBACK TRANSACTION");

    // TODO: create more prepared statements here
  }

  /**
   * Tries to log in as the given user.
   * @returns The authenticated user or null if login failed.
   */
  public User logIn(String handle, String password) throws SQLException {
    // TODO: implement this properly
    return null;
  }

  /**
   * Returns the list of all flights between the given cities on the given day.
   */
  public List<Flight[]> getFlights(
      int year, int month, int dayOfMonth, String originCity, String destCity)
      throws SQLException {

    List<Flight[]> results = new ArrayList<Flight[]>();

    Statement stmt = conn.createStatement();

    ResultSet directResults = stmt.executeQuery(String.format(
        "SELECT TOP (99) fid, name, flight_num, origin_city, dest_city, " +
        "    actual_time\n" +
        "FROM Flights F1, Carriers\n" +
        "WHERE carrier_id = cid AND actual_time IS NOT NULL AND " +
        "    year = %d AND month_id = %d AND day_of_month = %d AND " + 
        "    origin_city = '%s' AND dest_city = '%s'\n" +
        "ORDER BY actual_time ASC",
        year, month, dayOfMonth, originCity, destCity));
    while (directResults.next()) {
      results.add(new Flight[] {
          new Flight(directResults.getInt("fid"), year, month, dayOfMonth,
              directResults.getString("name"),
              directResults.getString("flight_num"),
              directResults.getString("origin_city"),
              directResults.getString("dest_city"),
              (int)directResults.getFloat("actual_time"))
        });
    }
    directResults.close();

    ResultSet twoHopResults = stmt.executeQuery(String.format(
        "SELECT TOP (99) F1.fid as fid1, C1.name as name1, " +
        "    F1.flight_num as flight_num1, F1.origin_city as origin_city1, " +
        "    F1.dest_city as dest_city1, F1.actual_time as actual_time1, " +
        "    F2.fid as fid2, C2.name as name2, " +
        "    F2.flight_num as flight_num2, F2.origin_city as origin_city2, " +
        "    F2.dest_city as dest_city2, F2.actual_time as actual_time2\n" +
        "FROM Flights F1, Flights F2, Carriers C1, Carriers C2\n" +
        "WHERE F1.carrier_id = C1.cid AND F1.actual_time IS NOT NULL AND " +
        "    F2.carrier_id = C2.cid AND F2.actual_time IS NOT NULL AND " +
        "    F1.year = %d AND F1.month_id = %d AND F1.day_of_month = %d AND " +
        "    F2.year = %d AND F2.month_id = %d AND F2.day_of_month = %d AND " +
        "    F1.origin_city = '%s' AND F2.dest_city = '%s' AND" +
        "    F1.dest_city = F2.origin_city\n" +
        "ORDER BY F1.actual_time + F2.actual_time ASC",
        year, month, dayOfMonth, year, month, dayOfMonth,
        originCity, destCity));
    while (twoHopResults.next()) {
      results.add(new Flight[] {
          new Flight(twoHopResults.getInt("fid1"), year, month, dayOfMonth,
              twoHopResults.getString("name1"),
              twoHopResults.getString("flight_num1"),
              twoHopResults.getString("origin_city1"),
              twoHopResults.getString("dest_city1"),
              (int)twoHopResults.getFloat("actual_time1")),
          new Flight(twoHopResults.getInt("fid2"), year, month, dayOfMonth,
              twoHopResults.getString("name2"),
              twoHopResults.getString("flight_num2"),
              twoHopResults.getString("origin_city2"),
              twoHopResults.getString("dest_city2"),
              (int)twoHopResults.getFloat("actual_time2"))
        });
    }
    twoHopResults.close();

    return results;
  }

  /** Returns the list of all flights reserved by the given user. */
  public List<Flight> getReservations(int userid) throws SQLException {
    // TODO: implement this properly
    return new ArrayList<Flight>();
  }

  /** Indicates that a reservation was added successfully. */
  public static final int RESERVATION_ADDED = 1;

  /**
   * Indicates the reservation could not be made because the flight is full
   * (i.e., 3 users have already booked).
   */
  public static final int RESERVATION_FLIGHT_FULL = 2;

  /**
   * Indicates the reservation could not be made because the user already has a
   * reservation on that day.
   */
  public static final int RESERVATION_DAY_FULL = 3;

  /**
   * Attempts to add a reservation for the given user on the given flights, all
   * occurring on the given day.
   * @returns One of the {@code RESERVATION_*} codes above.
   */
  public int addReservations(
      int userid, int year, int month, int dayOfMonth, List<Flight> flights)
      throws SQLException {

    // TODO: implement this in a transaction (see beginTransaction etc. below)

    return RESERVATION_FLIGHT_FULL;
  }

  /** Cancels all reservations for the given user on the given flights. */
  public void removeReservations(int userid, List<Flight> flights)
      throws SQLException {

    // TODO: implement this in a transaction (see beginTransaction etc. below)

  }

  /** Puts the connection into a new transaction. */    
  public void beginTransaction() throws SQLException {
    conn.setAutoCommit(false);  // do not commit until explicitly requested
    beginTxnStmt.executeUpdate();  
  }

  /** Commits the current transaction. */
  public void commitTransaction() throws SQLException {
    commitTxnStmt.executeUpdate(); 
    conn.setAutoCommit(true);  // go back to one transaction per statement
  }

  /** Aborts the current transaction. */
  public void rollbackTransaction() throws SQLException {
    abortTxnStmt.executeUpdate();
    conn.setAutoCommit(true);  // go back to one transaction per statement
  } 
}
