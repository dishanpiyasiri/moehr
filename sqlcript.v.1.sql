SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

DROP DATABASE IF EXISTS `moedb`;
CREATE DATABASE IF NOT EXISTS `moedb` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `moedb`;


DROP TABLE IF EXISTS moedb.title ;

CREATE TABLE IF NOT EXISTS moedb.title (
  title_id INT NOT NULL,
  title VARCHAR(45) NULL,
  PRIMARY KEY (title_id));
  
-- -----------------------------------------------------
-- Table moedb.designation
-- -----------------------------------------------------
DROP TABLE IF EXISTS moedb.designation ;

CREATE TABLE IF NOT EXISTS moedb.designation (
  designation_id INT NOT NULL,
  designation VARCHAR(45) NULL,
  PRIMARY KEY (designation_id));

  -- -----------------------------------------------------
-- Table moedb.Title
-- -----------------------------------------------------
DROP TABLE IF EXISTS moedb.titles ;

CREATE TABLE IF NOT EXISTS moedb.title (
  title_id INT NOT NULL,
  title VARCHAR(45) NULL,
  PRIMARY KEY (title_id));
  
  
-- -----------------------------------------------------
-- Table moedb.grade
-- -----------------------------------------------------
DROP TABLE IF EXISTS moedb.grade ;

CREATE TABLE IF NOT EXISTS moedb.grade (
  grade_id INT NOT NULL,
  grade VARCHAR(45) NULL,
  PRIMARY KEY (grade_id))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table moedb.marriedstate
-- -----------------------------------------------------
DROP TABLE IF EXISTS moedb.marriedstate ;

CREATE TABLE IF NOT EXISTS moedb.marriedstate (
  marriage_sate_id INT NOT NULL,
  marriage_sate VARCHAR(15) NULL,
  PRIMARY KEY (marriage_sate_id))
ENGINE = InnoDB;





-- -----------------------------------------------------
-- Table moedb.province
-- -----------------------------------------------------
DROP TABLE IF EXISTS moedb.province ;

CREATE TABLE IF NOT EXISTS moedb.province (
  province_id INT NOT NULL,
  name VARCHAR(45) NULL,
  PRIMARY KEY (province_id))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table moedb.district
-- -----------------------------------------------------
DROP TABLE IF EXISTS moedb.district ;

CREATE TABLE IF NOT EXISTS moedb.district (
  district_id INT NOT NULL,
  name VARCHAR(45) NULL,
  province_id INT references province(province_id),
  PRIMARY KEY (district_id))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table moedb.educationzone
-- -----------------------------------------------------
DROP TABLE IF EXISTS moedb.educationzone ;

CREATE TABLE IF NOT EXISTS moedb.educationzone (
  zone_id INT NOT NULL,
  name VARCHAR(45) NULL,
  district_id INT references district(district_id),
  PRIMARY KEY (zone_id))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table moedb.gsdevision
-- -----------------------------------------------------
DROP TABLE IF EXISTS moedb.gsdevision ;

CREATE TABLE IF NOT EXISTS moedb.gsdevision (
  devision_id INT NOT NULL,
  name VARCHAR(45) NULL,
  district_id INT  references district(district_id),
  zone_id INT references educationzone(zone_id),
  PRIMARY KEY (devision_id))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table moedb.nationality
-- -----------------------------------------------------
DROP TABLE IF EXISTS moedb.nationality ;

CREATE TABLE IF NOT EXISTS moedb.nationality (
  nationality_id INT NOT NULL,
  nationality VARCHAR(45) NULL,
  PRIMARY KEY (nationality_id))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table moedb.religion
-- -----------------------------------------------------
DROP TABLE IF EXISTS moedb.religion ;

CREATE TABLE IF NOT EXISTS moedb.religion (
  religion_id INT NOT NULL,
  religion VARCHAR(45) NULL,
  PRIMARY KEY (religion_id))
ENGINE = InnoDB;



-- -----------------------------------------------------
-- Table moedb.institute
-- -----------------------------------------------------
DROP TABLE IF EXISTS moedb.institute ;

CREATE TABLE IF NOT EXISTS moedb.institute (
  institute_id INT NOT NULL,
  name VARCHAR(45) NULL,
  address VARCHAR(45) NULL,
  telephone  char(12) NULL,
  email VARCHAR(45) NULL,
  web VARCHAR(45) NULL,
  zone_id VARCHAR(45) NULL,
  PRIMARY KEY (institute_id))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table moedb.department
-- -----------------------------------------------------
DROP TABLE IF EXISTS moedb.department ;

CREATE TABLE IF NOT EXISTS moedb.department (
  department_id INT NOT NULL,
  institute_id INT  NULL references institute(institute_id),
  name VARCHAR(45) NULL,
  telephone_1  char(12) NULL,
  telephone_2  char(12) NULL,
  extension INT(5) NULL,
  email VARCHAR(45) NULL,
  fax INT(10) NULL,
  department_head_nic INT(10) NULL,
  PRIMARY KEY (department_id))
ENGINE = InnoDB;



-- -----------------------------------------------------
-- Table moedb.appointmenttype
-- -----------------------------------------------------
DROP TABLE IF EXISTS moedb.appointmenttype ;

CREATE TABLE IF NOT EXISTS moedb.appointmenttype (
  app_id INT NOT NULL,
  app_type VARCHAR(45) NULL,
  description VARCHAR(45) NULL,
  PRIMARY KEY (app_id))
ENGINE = InnoDB;



-- Table moedb.employeebasicinfo
-- -----------------------------------------------------
DROP TABLE IF EXISTS moedb.employeebasicinfo ;

CREATE TABLE IF NOT EXISTS moedb.employeebasicinfo (
  nic char(12) primary key,
  name_with_initials VARCHAR(80) NULL,
  full_name VARCHAR(127) NULL,
  title_id INT NULL references title(title_id),
  dob DATE NULL,
  current_address VARCHAR(150) NULL,
  permenent_address VARCHAR(150) NULL,
  gender enum('Male','Female','Other'),
  marriage_sate_id int references marriedstate(marriage_sate_id),
  date_of_birth date,
  mobile_no varchar(15) NULL,
  land_no varchar(12) NULL,
  email VARCHAR(45) NULL,
  gs_devision_id int references gsdevision(devision_id)  ,
  nationality_id INT  references nationality(nationality_id),
  religion_id INT references religion(religion_id) ,
  educationzone_id int references educationzone(zone_id),
  image BLOB NULL, 
  file_path_of_photo varchar(70)
  );

-- Store image 100 x 100 for data optimizing (better to null) 


-- -----------------------------------------------------
-- Table moedb.employeeofficialinfo
-- -----------------------------------------------------
DROP TABLE IF EXISTS moedb.employeeofficialinfo ;

CREATE TABLE IF NOT EXISTS moedb.employeeofficialinfo (
  nic  char(12) references employeebasicinfo(nic),
  employement_id varchar(15) unique,
  institute_id INT references institute(institute_id),
  current_designation_id int references designation(designation_id),
  current_grade_id int references grade(grade_id),
  department_id INT references department(department_id),
  emp_official_mobile char(12),
  emp_official_email VARCHAR(45) NULL,
  wop_no VARCHAR(45) NULL,
  insuarence_id VARCHAR(45) NULL,
  appt_type_id INT references appointmenttype(app_id),
  app_subject VARCHAR(45) NULL,
  app_letter_date DATE NULL,
  app_letter_code VARCHAR(45) NULL,
  app_date DATE NULL,
  sallary_no VARCHAR(45) NULL,
  PRIMARY KEY (nic))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table moedb.marriedstate Change History
-- -----------------------------------------------------
DROP TABLE IF EXISTS moedb.marriedstatechangehistory ;
create table marriedstatechangehistory
(
	id int primary key,
	nic char(12) references employeebasicinfo(nic),
	marriage_sate_id int references marriedstate(marriage_sate_id),
	dateofchange date
);

-- -----------------------------------------------------

-- -----------------------------------------------------
-- Table moedb.degree
-- -----------------------------------------------------
DROP TABLE IF EXISTS moedb.degree ;

CREATE TABLE IF NOT EXISTS moedb.degree (
  degree_id INT NOT NULL,
  name VARCHAR(45) NULL,
  PRIMARY KEY (degree_id))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table moedb.salutation
-- -----------------------------------------------------
DROP TABLE IF EXISTS moedb.salutation ;

CREATE TABLE IF NOT EXISTS moedb.salutation (
  salutation_id INT NOT NULL,
  salutation VARCHAR(45) NULL,
  PRIMARY KEY (salutation_id))
ENGINE = InnoDB;





-- -----------------------------------------------------
-- Table moedb.subject
-- -----------------------------------------------------
DROP TABLE IF EXISTS moedb.subject ;

CREATE TABLE IF NOT EXISTS moedb.subject (
  subject_id INT NOT NULL,
  subject VARCHAR(45) NULL,
  PRIMARY KEY (subject_id))
ENGINE = InnoDB;



-- -----------------------------------------------------
-- Table moedb.educationqualification
-- -----------------------------------------------------
DROP TABLE IF EXISTS moedb.educationqualification ;

CREATE TABLE IF NOT EXISTS moedb.educationqualification (
  qualification_id INT NOT NULL,
  name_of_qualification VARCHAR(45) NULL,
  institute_id INT   references institute(institute_id),
  PRIMARY KEY (qualification_id))
ENGINE = InnoDB;


 



-- -----------------------------------------------------
-- Table moedb.designationhistory
-- -----------------------------------------------------
DROP TABLE IF EXISTS moedb.designationhistory ;

CREATE TABLE IF NOT EXISTS moedb.designationhistory (
   nic char(12) references employeeofficialinfo(nic),
  designation_id INT NULL,
  affectiong_date VARCHAR(45) NULL,

  PRIMARY KEY (nic))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table moedb.changehistory
-- -----------------------------------------------------
DROP TABLE IF EXISTS moedb.changehistory ;

CREATE TABLE IF NOT EXISTS moedb.changehistory (
  id INT NOT NULL,
  grade_id INT NULL,
  nic char(12) references  employeeofficialinfo (nic),
  affectiong_date DATE NULL,
  increment_date DATE NULL,
  PRIMARY KEY (id))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table moedb.school
-- -----------------------------------------------------
DROP TABLE IF EXISTS moedb.school ;

CREATE TABLE IF NOT EXISTS moedb.school (
  sences_id INT NOT NULL,
  institute_id INT NULL,
  school_type VARCHAR(45) NULL,
  np VARCHAR(45) NULL,
  difficultiea VARCHAR(45) NULL,
  PRIMARY KEY (sences_id))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table moedb.workinghistory
-- -----------------------------------------------------
DROP TABLE IF EXISTS moedb.workinghistory ;

CREATE TABLE IF NOT EXISTS moedb.workinghistory (
  nic char(12) references employeeofficialinfo (nic),
  institute_id INT NULL,
  transfer_date DATE NULL,
  reason VARCHAR(255) NULL,
  PRIMARY KEY (nic))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
