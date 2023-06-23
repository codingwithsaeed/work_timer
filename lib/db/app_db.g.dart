// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_db.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDB {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDBBuilder databaseBuilder(String name) => _$AppDBBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDBBuilder inMemoryDatabaseBuilder() => _$AppDBBuilder(null);
}

class _$AppDBBuilder {
  _$AppDBBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDBBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDBBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDB> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDB();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDB extends AppDB {
  _$AppDB([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  AppDao? _appDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Month` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `duty_hours` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `work_day` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `date` INTEGER NOT NULL, `arrival` TEXT NOT NULL, `exit` TEXT NOT NULL, `is_remote` INTEGER NOT NULL, `month_id` INTEGER NOT NULL, FOREIGN KEY (`month_id`) REFERENCES `Month` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  AppDao get appDao {
    return _appDaoInstance ??= _$AppDao(database, changeListener);
  }
}

class _$AppDao extends AppDao {
  _$AppDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _monthInsertionAdapter = InsertionAdapter(
            database,
            'Month',
            (Month item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'duty_hours': item.dutyHours
                }),
        _workDayInsertionAdapter = InsertionAdapter(
            database,
            'work_day',
            (WorkDay item) => <String, Object?>{
                  'id': item.id,
                  'date': _dateTimeConverter.encode(item.date),
                  'arrival': _timeConverter.encode(item.arrival),
                  'exit': _timeConverter.encode(item.exit),
                  'is_remote': _boolConverter.encode(item.isRemote),
                  'month_id': item.monthId
                }),
        _monthUpdateAdapter = UpdateAdapter(
            database,
            'Month',
            ['id'],
            (Month item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'duty_hours': item.dutyHours
                }),
        _workDayUpdateAdapter = UpdateAdapter(
            database,
            'work_day',
            ['id'],
            (WorkDay item) => <String, Object?>{
                  'id': item.id,
                  'date': _dateTimeConverter.encode(item.date),
                  'arrival': _timeConverter.encode(item.arrival),
                  'exit': _timeConverter.encode(item.exit),
                  'is_remote': _boolConverter.encode(item.isRemote),
                  'month_id': item.monthId
                }),
        _monthDeletionAdapter = DeletionAdapter(
            database,
            'Month',
            ['id'],
            (Month item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'duty_hours': item.dutyHours
                }),
        _workDayDeletionAdapter = DeletionAdapter(
            database,
            'work_day',
            ['id'],
            (WorkDay item) => <String, Object?>{
                  'id': item.id,
                  'date': _dateTimeConverter.encode(item.date),
                  'arrival': _timeConverter.encode(item.arrival),
                  'exit': _timeConverter.encode(item.exit),
                  'is_remote': _boolConverter.encode(item.isRemote),
                  'month_id': item.monthId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Month> _monthInsertionAdapter;

  final InsertionAdapter<WorkDay> _workDayInsertionAdapter;

  final UpdateAdapter<Month> _monthUpdateAdapter;

  final UpdateAdapter<WorkDay> _workDayUpdateAdapter;

  final DeletionAdapter<Month> _monthDeletionAdapter;

  final DeletionAdapter<WorkDay> _workDayDeletionAdapter;

  @override
  Future<List<Month>> getMonths() async {
    return _queryAdapter.queryList('SELECT * FROM Month',
        mapper: (Map<String, Object?> row) => Month(
            id: row['id'] as int?,
            name: row['name'] as String,
            dutyHours: row['duty_hours'] as int));
  }

  @override
  Future<List<WorkDay>> getDays(int monthId) async {
    return _queryAdapter.queryList('SELECT * FROM work_day WHERE month_id = ?1',
        mapper: (Map<String, Object?> row) => WorkDay(
            id: row['id'] as int?,
            date: _dateTimeConverter.decode(row['date'] as int),
            arrival: _timeConverter.decode(row['arrival'] as String),
            exit: _timeConverter.decode(row['exit'] as String),
            isRemote: _boolConverter.decode(row['is_remote'] as int),
            monthId: row['month_id'] as int),
        arguments: [monthId]);
  }

  @override
  Future<int> insertMonth(Month month) {
    return _monthInsertionAdapter.insertAndReturnId(
        month, OnConflictStrategy.abort);
  }

  @override
  Future<int> insertDay(WorkDay day) {
    return _workDayInsertionAdapter.insertAndReturnId(
        day, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateMonth(Month month) async {
    await _monthUpdateAdapter.update(month, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateDay(WorkDay day) async {
    await _workDayUpdateAdapter.update(day, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteMonth(Month month) async {
    await _monthDeletionAdapter.delete(month);
  }

  @override
  Future<void> deleteDay(WorkDay day) async {
    await _workDayDeletionAdapter.delete(day);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
final _timeConverter = TimeConverter();
final _boolConverter = BoolConverter();
