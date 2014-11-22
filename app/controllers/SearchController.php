<?php

class SearchController extends BaseController {

    /**
     * Search by author name.
     *
     * @return void
     */
    public function searchByAuthorName()
    {

	    if (Input::has('keyword'))
		{
		    $keyword = Input::get("keyword");
		    $lowerKeyword = mb_strtolower($keyword);
			$books = DB::table('book')->whereRaw('lower(author) LIKE ?', array("%$lowerKeyword%"))->get();
		}
		else 
		{
			$keyword = '';
			$books = array();
		}

		$booksCount = count($books);
		$tblFlag = $booksCount ? true : false;

	    return View::make('search')
	    	->with('keyword', $keyword)
	    	->with('books', $books)
	    	->with('tblFlag', $tblFlag)
	    	->with('booksCount', $booksCount);
	}

}