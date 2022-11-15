abstract class AbstractService<T> {
  Future<void> save(T entity);

  Future<void> remove(String id);
}
