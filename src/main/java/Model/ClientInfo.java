package Model;


public class ClientInfo {

    private long id;
    private String first_name;
    private String last_name;
    private String patronumic;
    private int age;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }


    public String getFirstname() {
        return first_name;
    }

    public void setFirstname(String first_name) {
        this.first_name = first_name;
    }

    public String getLast_name() {
        return last_name;
    }

    public void setLast_name(String last_name) {
        this.last_name = last_name;
    }

    public String getPatronumic() {
        return patronumic;
    }

    public void setPatronumic(String patronumic) {
        this.patronumic = patronumic;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public ClientInfo (long id, String first_name, String last_name, String patronumic, int age)
    {
        this.id = id;
        this.first_name = first_name;
        this.last_name = last_name;
        this.patronumic = patronumic;
        this.age = age;
    }


}
