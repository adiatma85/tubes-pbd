<?php
// untuk mode edit
	if(isset($list_kolom)){
		foreach($list_kolom as $kol)
			isset($detail_data[$kol['COLUMN_NAME']]) ? $var[$kol['COLUMN_NAME']]=$detail_data[$kol['COLUMN_NAME']] :  $var[$kol['COLUMN_NAME']]=null;
		isset($detail_data['id']) ? $kode_penerbit=$detail_data['id'] :  $kode_penerbit=null;
	}
?>

<div class="container">

<form method="POST" role="form" action="<?php echo base_url();?>index.php/myController/form/<?php echo $tabel;?>/<?php echo $this->uri->segment(4);?>" class="form-horizontal">
<?php
if(isset($list_kolom)){
	foreach($list_kolom as $kol){
?>
<div class="form-group">
	<label for=<?php echo $kol['COLUMN_NAME'];?> class="control-label col-md-2"><?php echo $kol['COLUMN_NAME'];?> </label>
	<div class=" col-md-6">
	<?php
		 echo '<input class="form-control" name='.$kol['COLUMN_NAME'].' placeholder="Masukan data '.$kol['COLUMN_NAME'].'" autocomplete="off" value='.$var[$kol['COLUMN_NAME']];
		 echo ' ></input>'
	?>
	</div>
</div>
<?php
}
}
?>

<div class="form-group">
	<div class="col-md-offset-2 col-md-10">
	<button type="submit" name="submit" class="btn btn-primary"><span class="glyphicon glyphicon-save"></span> Simpan</button>
	</div>
</div>

</form>
</div>
