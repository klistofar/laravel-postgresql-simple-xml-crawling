<?php 

class Book extends Eloquent {

	/**
	 * The database table used by the model.
	 *
	 * @var string
	 */
    protected $table = 'book';

    /**
	 * Store information into DB, basic variant
	 *
	 * @return void
	 */
    public static function saveAllBooksIntoDB_Basic($dataArr = array()) 
    {
    	if (count($dataArr) > 0) 
		{
			foreach ($dataArr AS $data) 
			{
				$books = DB::table('book')
					->where('name', $data['name'])
					->where('author', $data['author'])->get();

			    if ($books) 
			    {
			    	foreach ($books as $book) 
			    	{
			    		DB::table('book')->where('id', $book->id)->update(array('inserted_at' => date('Y-m-d')));
			    	}
			    }
			    else
			    {
			    	$id = DB::table('book')->insertGetId(
			    		array(
			    			'name' => $data['name'], 
			    			'author' => $data['author'], 
			    			'inserted_at' => date('Y-m-d')
			    		)
			    	);
			    }
			}
		}
	}


	/**
	 * Store information into DB, using one big INSERT query 
	 *
	 * @return void
	 */
    public static function saveAllBooksIntoDB_BigInsert($dataArr = array()) 
    {
    	if (count($dataArr) > 0) 
		{
			$sqlInsert = '';
			$sqlInsertValues = '';

			foreach ($dataArr AS $data) 
			{
				$books = DB::table('book')
					->where('name', $data['name'])
					->where('author', $data['author'])->get();

			    if ($books) 
			    {
			    	foreach ($books as $book) 
			    	{
			    		DB::table('book')->where('id', $book->id)->update(array('inserted_at' => date('Y-m-d')));
			    	}
			    }
			    else
			    {
			    	//Esace single quotes, can append more special characters
			    	$name = str_replace(array("'"), array("''"), $data['name']);
			    	$author = str_replace(array("'"), array("''"), $data['author']);

			    	$sqlInsertValues .= "('".$name."', '".$author."', '".date('Y-m-d')."'), ";
			    }
			}

			if ($sqlInsertValues)
			{
				$sqlInsert .= 'INSERT INTO book (name, author, inserted_at) VALUES '.$sqlInsertValues;
				$sqlInsert = mb_substr(trim($sqlInsert), 0, -1).';';

				DB::statement($sqlInsert);
			}

		}
	}

	/**
	 * Store information into DB, use PostgreSQL function, logic inside
	 *
	 * @return void
	 */
    public static function saveAllBooksIntoDB_FunctionLogic($dataArr = array()) 
    {
    	if (count($dataArr) > 0) 
		{
			foreach ($dataArr AS $data) 
			{
		    	$results = DB::select("select save_to_db(?, ?)", array($data['name'], $data['author']));
		    }
		}
	}

}