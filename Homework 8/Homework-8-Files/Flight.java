/** Records information about a flight in the database. */
public class Flight {

  /** Stores the unique ID of this flight. */
  public final int id;

  /** Stores the year of the flight. */
  public final int year;

  /** Stores the number (from 1) of the month in which the flight occurs. */
  public final int month;

  /** Stores the day of the month in which the flight occurs. */
  public final int dayOfMonth;

  /** Stores the full name of the carrier (e.g., Alaska Airlines Inc.). */
  public final String carrier;

  /** Stores the flight number (which is unique only within the carrier). */
  public final String flightNum;

  /** Stores the name of the city from which the flight originates. */
  public final String originCity;

  /** Stores the name of the city at which the flight terminates. */
  public final String destCity;

  /** Stores the flight time in minutes. */
  public final int timeMinutes;

  /** Creates a flight with the given properties. */
  public Flight(
      int id, int year, int month, int dayOfMonth, String carrier,
      String flightNum, String originCity, String destCity, int timeMinutes) {
    this.id = id;
    this.year = year;
    this.month = month;
    this.dayOfMonth = dayOfMonth;
    this.carrier = carrier.trim();
    this.flightNum = flightNum.trim();
    this.originCity = originCity.trim();
    this.destCity = destCity.trim();
    this.timeMinutes = timeMinutes;
  }
}
