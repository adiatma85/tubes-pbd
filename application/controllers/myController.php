<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class myController extends CI_Controller {
	/*===================== AREA KODE 1 JANGAN DIUBAH =========================================||*/
	/*||*/ private $thisKolom="";
	/*||*/ private $pk="";
	/*||*/ public function __construct(){
	/*||*/ parent::__construct();
	/*||*/ $this->load->model('myModel','',TRUE);	
	/*||*/ }
	/*||*/ public function setTable($tabel){
	/*||*/ 	$this->thisKolom=$this->myModel->getKolom($tabel);
	/*||*/ 	$x=$this->myModel->db->query("show columns from ".$tabel." where `Key` = 'PRI'"); 
	/*||*/ 	$x=$x->row();
	/*||*/ 	$this->pk=$x->Field;
	/*||*/  }
	/*===================== END AREA KODE 1 ===================================================||*/

	public function index()
	{
		$data['title']='Contoh Penerapan MySQL Stored Procedure di Codeigniter';
		$data['header']='<h1></h1>';
		$data['konten']='<p></p>';
		
		/*---------------- AREA KODE 2 JANGAN DIUBAH -------------------------------------------------||*/
		/*||*/ $this->load->view('v_dashboard',$data);
		/*-----------------END AREA KODE 1 -----------------------------------------------------------||*/
	}
	
	
	public function tampil($tabel){
		$data['title']='Contoh Penerapan MySQL Stored Procedure di Codeigniter';
		$data['header']='<h1>List Data '.$tabel.'</h1>';
		$data['konten']='<p>Berikut List Data yang terdaftar dalam database, klik icon pada sebelah kanan tabel untuk mengelola data , dan kilk tombol tambah untuk menambah data !</p>';
		
		/*---------------- AREA KODE 3 JANGAN DIUBAH -------------------------------------------------||*/
		/*||*/ $data['page']='v_data_dashboard';
		/*||*/ $this->setTable($tabel);
		/*||*/ $data['tabel']=$tabel;
		/*||*/ $data['pk']=$this->pk;
		/*||*/ $data['list_kolom']=$this->thisKolom;
		/*||*/ $data['list_data']=$this->myModel->tampil($tabel,'*',$this->thisKolom);
		/*||*/ $this->load->view('v_dashboard',$data);	
		/*-----------------END AREA KODE 3 -----------------------------------------------------------||*/
	}

	public function form($tabel,$id_data=null){
		$data['title']='Contoh Penerapan MySQL Stored Procedure di Codeigniter';
		
		/*---------------- AREA KODE 4 JANGAN DIUBAH ---------------------------------------------------------------------------------------||*/
		/*||*/ $this->setTable($tabel);
		/*||*/ $data['tabel']=$tabel;
		/*||*/ $this->form_validation->set_rules($this->pk,$this->pk,'required');
		/*||*/ $id_data==null ? $aksinya='Penambahan' : $aksinya='Perubahan';	
		/*||*/ $aksinya=='Perubahan' ? $data['detail_data']=$this->myModel->detail($tabel,$id_data,$this->pk) : $data['detail_data']=null;
		/*||*/ $data['header']='<h1>'.$aksinya.' Data '.$tabel.'</h1>';
		/*||*/ $data['konten']='<p>Untuk melakukan '.strtolower($aksinya).' data, silahkan isi semua field pada form dibawah ini !</p>';
		/*||*/ 
		/*||*/ if ($this->form_validation->run() == TRUE){
		/*||*/ 		if($id_data==null){	
		/*||*/ 			$value="";
		/*||*/ 			foreach($this->thisKolom as $kol)
		/*||*/ 				$value=	$value."'".$this->input->post($kol['COLUMN_NAME'])."',";
		/*||*/ 			$value=substr($value, 0, -1);	
		/*||*/ 			$this->myModel->tambah($tabel,$value);
        /*||*/          echo '<script>alert(\'Data Telah Disimpan\')</script>';		
		/*||*/ 		} else {
		/*||*/			echo '<script>alert(\'Data Telah Update\')</script>';
		/*||*/ 			$value="";
		/*||*/ 			foreach($this->thisKolom as $kol)
		/*||*/ 				$value=	$value.$kol['COLUMN_NAME']."='".$this->input->post($kol['COLUMN_NAME'])."',";						
		/*||*/			$value=substr($value, 0, -1);	
		/*||*/			$this->myModel->ubah($tabel,$this->pk,$id_data,$value);
		/*||*/		}
		/*||*/ 	redirect(base_url().'index.php/myController/tampil/'.$tabel,'refresh');					
		/*||*/ }
		/*||*/ $data['page']='v_form_input';
		/*||*/ $data['list_kolom']=$this->thisKolom;
		/*||*/ $data['list_data']=$this->myModel->tampil($tabel,'*',$this->thisKolom);
		/*||*/ $this->load->view('v_dashboard',$data);			
		/*-----------------END AREA KODE 4 ------------------------------------------------------------------------------------------------||*/
	}

	public function hapus($tabel,$id_data){
	/*---------------- AREA KODE 5 JANGAN DIUBAH ---------------------------------------------------------------------------------------||*/
	/*||*/  $this->setTable($tabel);
	/*||*/ 	$this->myModel->hapus($tabel,$this->pk,$id_data);
	/*||*/ 	redirect(base_url().'index.php/myController/tampil/'.$tabel,'refresh');
	/*-----------------END AREA KODE 5 ------------------------------------------------------------------------------------------------||*/
	}
	
	
}
