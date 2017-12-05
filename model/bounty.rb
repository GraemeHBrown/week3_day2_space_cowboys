require('pg')

class Bounty
  attr_reader :id
  attr_accessor :name, :bounty_value, :favourite_weapon, :collected_by

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @bounty_value = options['bounty_value'].to_i
    @favourite_weapon = options['favourite_weapon']
    @collected_by = options['collected_by']
  end

def save()
  db = PG.connect({ dbname: 'space_cowboys', host: 'localhost'})
  sql = "
      INSERT INTO bounties (
        name,
        bounty_value,
        favourite_weapon,
        collected_by
      ) VALUES (
        $1, $2, $3, $4
      ) RETURNING *
  ;"
  values = [@name, @bounty_value, @favourite_weapon, @collected_by]
  db.prepare("save", sql)
  @id = db.exec_prepared("save", values)[0]['id'].to_i
  db.close
end

def update()
  db = PG.connect({ dbname: 'space_cowboys', host: 'localhost'})
  sql = "
      UPDATE bounties SET (
          name,
          bounty_value,
          favourite_weapon,
          collected_by
        ) = (
          $1, $2, $3, $4
        ) WHERE id = $5
          ;"
  values = [@name, @bounty_value, @favourite_weapon, @collected_by, @id]
  db.prepare("update", sql)
  db.exec_prepared("update", values)
  db.close
end

def delete()
      db = PG.connect({ dbname: 'space_cowboys', host: 'localhost'})
      sql = "DELETE FROM bounties WHERE id = $1;"
      values = [@id]
      db.prepare("delete_one", sql)
      db.exec_prepared("delete_one", values)
      db.close()
  end

  def self.delete_all()
        db = PG.connect({ dbname: 'space_cowboys', host: 'localhost'})
        sql = "DELETE FROM bounties;"
        db.prepare("delete_all", sql)
        db.exec_prepared("delete_all")
        db.close()
    end

  def self.find_by_id(id)
    db = PG.connect({ dbname: 'space_cowboys', host: 'localhost'})
    sql = "SELECT * FROM bounties WHERE id = $1;"
    values = [id]
    db.prepare("find_by_id", sql)
    bounty = db.exec_prepared("find_by_id", values)
    db.close()
    return bounty.map{|bounty| Bounty.new(bounty)}
  end

end
