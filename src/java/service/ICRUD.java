package service;

import java.util.List;

public interface ICRUD<T> {
    public void create(T t);
    public T read(int id);
    public void update(T t);
    public void delete(int id);
    public List<T> getAll();
}
