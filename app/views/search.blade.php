@extends('layout')

@section('content')

    <!-- Search for row -->
    <div class="row">
        <div class="col-lg-12">
        	{{ Form::open(array('url' => Request::root().'/search', 'method' => 'get', 'class' => 'form-horizontal', 'role' => 'search', 'id' => 'form_search')) }}
				<div class="form-group form-group-lg">
					{{ Form::label('keyword', 'Keyword', array('class' => 'col-sm-2 control-label')) }}
					<div class="col-sm-7">
						{{ Form::text('keyword', $keyword, array('class' => 'form-control input-lg', 'placeholder' => 'Author name')) }}
					</div>
				</div>
				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-5">
					  {{ Form::submit('Search', array('class' => 'btn btn-primary')) }}
					</div>
				</div>
			{{ Form::close() }}
        </div>
    </div>
    <!-- /.row -->

    @if ($tblFlag)
    
     <!-- Search results row -->
    <div class="row">
        <div class="col-lg-12">
             <table class="table table-hover">
				<caption>Found results: {{$booksCount}}<hr></caption>
				<thead>
					<tr>
						<th>#</th>
						<th>Name</th>
						<th>Author</th>
						<th>Inserted At</th>
					</tr>
				</thead>
				<tbody>
				@foreach($books as $i => $book)
			        <tr>
						<td>{{ $i+1 }}.</td>
						<td>{{ $book->name }}</td>
						<td>{{ $book->author }}</td>
						<td>{{ $book->inserted_at }}</td>
					</tr>
			    @endforeach
				</tbody>
		    </table>
        </div>
    </div>
    <!-- /.row -->
    @endif

@stop