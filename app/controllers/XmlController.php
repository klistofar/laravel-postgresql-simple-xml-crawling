<?php

class XmlController extends BaseController {

	/**
	 * XML files list.
	 *
	 * @var array
	 */
	public $filesArr = array();

	/**
	 * Valid file extension, XML only
	 *
	 * @var array
	 */
	public $validFileExt = array('xml');

	/**
	 * Default file directory with XML's (for crawling).
	 *
	 * @var string
	 */
	public $fileDir = '/files/';

	/**
	 * Errors when loading the xml file.
	 *
	 * @var array
	 */
	public $fileErrors = array();

	/**
	 * HTML book info for each file.
	 *
	 * @var string
	 */
	public $fileTablesStr = '';

	/**
     * Class constructor, set full path to directory.
     *
     * @return void
     */
	public function __construct() 
	{
		$this->fileDir = public_path().$this->fileDir;
	}

    /**
     * Show XML files content.
     *
     * @return void
     */
    public function showXmlContent()
    {

		/*$mtime = microtime(); 
		$mtime = explode(" ",$mtime); 
		$mtime = $mtime[1] + $mtime[0]; 
		$starttime = $mtime; */

    	//Get XML files list
    	$this->getXMLfilesList($this->fileDir,'addXmlFile');

    	//Get XML files list
    	$this->readXmlData();

    	/*$mtime = microtime(); 
		$mtime = explode(" ",$mtime); 
		$mtime = $mtime[1] + $mtime[0]; 
		$endtime = $mtime; 
		$totaltime = ($endtime - $starttime); 
		echo "This page was created in ".$totaltime." seconds";
		die();*/

	    return View::make('read')
	    	//->with('filesArr', $this->filesArr)
	    	->with('fileTablesStr', $this->fileTablesStr)
	    	->with('fileErrors', $this->fileErrors);
	}

	/**
     * Recursively get XML files list from given directory structure.
     *
     * @return void
     */
	public function getXMLfilesList($base, $fileFunc) 
	{
		$subdirs = opendir($base);
		while (($subdir = readdir($subdirs))!==false) 
		{
			$path=$base.$subdir;
			if (is_file($path)) 
			{
				if ($fileFunc!==null) 
				{
					$this->$fileFunc($path);
				}
			}
			else 
			{
				if (($subdir!='.') && ($subdir!='..')) 
				{
					$this->getXMLfilesList($path.'/', $fileFunc);
				}
			}
		}
	}

	/**
     * Add XML file in array.
     *
     * @return void
     */
	public function addXmlFile($path) 
	{
		$filePath = trim($path);
		$fileExt = File::extension($filePath);

		if (in_array($fileExt, $this->validFileExt)) 
		{
			$this->filesArr[] = trim($path);
		}
	}

	/**
     * Get XML files count.
     *
     * @return integer
     */
	public function filesCount() 
	{
		return count($this->filesArr);
	}

	/**
     * Prepare unique two demensional array.
     *
     * @return array
     */
	public function array_unique_2d($array)
	{
		if (is_array($array))
		{
			$result = array_map("unserialize", array_unique(array_map("serialize", $array)));
		}
		else 
		{
			$result = array();
		}

		return $result;
	}

	/**
     * Store XML files content into DB.
     * 
     * @return void
     */
	public function readXmlData() 
	{
		if ($this->filesCount()) 
		{
			$i = $k = 0;
			$bookArr = array();
			$fileRowContent = $bookRowContent = '';
			foreach ($this->filesArr AS $val) 
			{

				//Load XML file into memory, enable errors on loading
				libxml_use_internal_errors(true);
				$xml = simplexml_load_file($val);

				//Check for valid XML structure
				if ($xml) 
				{

					$j = 1;
					$bookRowContent = '';

					//Parse books data for each XML file
					$fileRowContent .= '<div class="row">
										    <div class="col-lg-12">
										        <table class="table table-hover">
													<caption>'.($i+1).') File path: <strong>'.$val.'</strong></caption>
													<thead>
														<tr>
															<th>#</th>
															<th>Name</th>
															<th>Author</th>
														</tr>
													</thead>
													<tbody>';
					foreach ($xml->book AS $node) 
					{
						//Prepare book array data for DB saving
						$bookArr[$k]['author'] = isset($node->author) ? (string) $node->author : '';
						$bookArr[$k]['name'] = isset($node->name) ? (string) $node->name : '';

						$bookRowContent .= '<tr>
												<td>'.($j++).'.</td>
												<td>'.$bookArr[$k]['name'].'</td>
												<td>'.$bookArr[$k]['author'].'</td>
											</tr>';
						$k++;
					}

					$fileRowContent .= $bookRowContent .'</tbody>
											    </table>
										    </div>
										</div>
										<hr>';

					$i++;
				}
				else 
				{
					//Get XML errors for each XML file
				    foreach(libxml_get_errors() as $ekey => $error) 
				    {
				        $this->fileErrors[$ekey]['file'] = $error->file;
				        $this->fileErrors[$ekey]['message'] = $error->message;
				    }
				}
				unset($xml);
			}

			//Set html tables rows for each file
			$this->fileTablesStr = $fileRowContent;

			//Remove duplicate array items
			$bookArr = $this->array_unique_2d($bookArr);

			//Save books info from all XML files into DB

			//Basic variant
			//Book::saveAllBooksIntoDB_Basic($bookArr);

			//Variant with one big insert
			//Book::saveAllBooksIntoDB_BigInsert($bookArr);

			//Variant with internal SQL function 
			Book::saveAllBooksIntoDB_FunctionLogic($bookArr);
			
		}
	}

}