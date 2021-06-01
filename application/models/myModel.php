<?php
/*=============================== SEMUA KODE MODEL JANGAN DIUBAH ============================================================================||*/
defined('BASEPATH') OR exit('No direct script access allowed');

class myModel extends CI_Model {
	public function getKolom($tabel){
		// menjalankan stored procedure tampil_penerbit()
		$sql_query=$this->db->query("SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE table_name = '".$tabel."'");  
            if($sql_query->num_rows()>0){
                return $sql_query->result_array();
            }
	}
	public function tampil($tabel,$keyword,$list_kolom){
		// menjalankan stored procedure tampil_penerbit()
		$kolom="";
		foreach($list_kolom as $kol)
			$kolom=	$kolom.$kol['COLUMN_NAME'].",";
		$kolom=substr($kolom, 0, -1);
		$sql_query=$this->db->query("call SP_SEARCH_TABEL('".$tabel."','".$keyword."','".$kolom."')");  
	    mysqli_next_result( $this->db->conn_id);
            if($sql_query->num_rows()>0){
                return $sql_query->result_array();
            }
	}
	public function detail($tabel,$value,$kolom){
		// menjalankan stored procedure detail_penerbit()
		$sql_query=$this->db->query('call SP_SEARCH_TABEL("'.$tabel.'","'.$value.'","'.$kolom.'")');  	  				
	    mysqli_next_result( $this->db->conn_id);
            if($sql_query->num_rows()==1){
                return $sql_query->row_array();
            }
	}
	public function hapus($tabel,$kolom,$value){
		$sql_query=$this->db->query('call SP_DELETE_TABEL("'.$tabel.'","'.$kolom.'","'.$value.'")');    	  				
	}
	public function tambah($tabel,$value){
		$sql_query=$this->db->query('call SP_INSERT_TABEL("'.$tabel.'","'.$value.'")');  
	}
	public function ubah($tabel,$pk,$id_data,$value){
		$sql_query=$this->db->query('call SP_UPDATE_TABEL("'.$tabel.'","'.$pk.'","'.$id_data.'","'.$value.'")');   	  				
	}
}
/*=============================== SEMUA KODE MODEL JANGAN DIUBAH ============================================================================||*/
