package com.example.Client.Model;


public class ClientInfo {

    private long id;
    private String firstName;
    private String lastName;
    private String patronumic;
    private int age;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
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

    public ClientInfo(long id, String firstName, String lastName, String patronumic, int age) {
        this.id = id;
        this.firstName = firstName;
        this.lastName = lastName;
        this.patronumic = patronumic;
        this.age = age;
    }

}
