@extends('layout')

@section('content')

<!-- Row Heading -->
<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">XML files content</h1>
    </div>
</div>
<!-- /.row -->

<!-- Row meessages -->
<?php 
	if (count($fileErrors))
		{
			foreach ($fileErrors as $key => $error) 
			{
?>
				<div class="row">
				    <div class="col-lg-12">
				        <div class="alert alert-danger" role="alert">
						  <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
						  <span class="sr-only">Error: <?php echo $error['message']; ?></span>
						  <strong>Failed loading XML file:</strong> <?php echo $error['message']; ?> in `<?php echo $error['file']; ?>`
						</div>
				    </div>
				</div>
				<!-- /.row -->
<?php 		}
		}
?>

{{$fileTablesStr}}

@stop