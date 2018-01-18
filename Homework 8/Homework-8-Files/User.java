/** Stores information about a user in the database. */
public class User {

  /** Stores the ID of the authenticated user. */
  public final int id;

  /** Stores the handle of the authenticated user. */
  public final String handle;

  /** Stores the full name of the authenticated user. */
  public final String fullName;

  /** Creates a User with the given properties. */
  public User(int id, String handle, String fullName) {
    this.id = id;
    this.handle = handle;
    this.fullName = fullName;
  }

}
