<?php
/*===================== CODE DIBAWAH TIDAK BOLEH DI UBAH KECUALI ANDA PAHAM CODE NYA DAN INGIN MEMODIFIKASI ==================================||*/
?>

<p>
<a href="<?php echo base_url();?>index.php/myController/form/<?php echo $tabel;?>"
 class="btn btn-primary"><span class="glyphicon glyphicon-plus-sign"></span> Tambah</a>

</p>
<table class="table">
<thead>
	<tr>
	<th>#</th>
	<?php
		if(isset($list_kolom)){
			foreach($list_kolom as $kol)
				echo'<th>'.$kol['COLUMN_NAME'].'</th>';
		}
	?>
	</tr>
</thead>
<tbody>
<?php
if(isset($list_data)){
	$no=null;
	foreach($list_data as $row){
	$no++;	
	
	echo'<tr>
	<td>'.$no.'</td>';
	if(isset($list_kolom)){
		foreach($list_kolom as $kol)
				echo'<td>'.$row[$kol['COLUMN_NAME']].'</td>';
	}
	echo '<td>
		<a href="'.base_url().'index.php/myController/form/'.$tabel.'/'.$row[$pk].'">
		<span class="glyphicon glyphicon-pencil" title="Edit"></span></a>
		&nbsp;
		<a OnClick="javascript:return(window.confirm(\'Anda yakin akan menghapus data ??\')) " href="'.base_url().'index.php/myController/hapus/'.$tabel.'/'.$row[$pk].'">
		<span class="glyphicon glyphicon-trash" title="Hapus"></span></a>
	</td>
	</tr>';
	}
}
?>
</tbody>
</table>
<?php
/*======================================================================================================================================================================||*/
?>
