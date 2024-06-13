package tech.csm.domain;

import java.io.Serializable;

import org.springframework.web.multipart.MultipartFile;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Entity
@Getter
@Setter
@ToString
@Table(name = "usertbl")
@AllArgsConstructor
@NoArgsConstructor
public class User implements Serializable {

	@Id
	@Column(name="uid")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int uid;
	
	@Column(name="name")
	private String name;
	
	@Column(name="email")
	private String email;
	
	@Column(name="password")
	private String password;
	
	@Column(name="address")
	private String address;
	
	@Column(name="photo")
	private String photo;
	
	@Transient
    MultipartFile file;
	
    @ManyToOne
    @JoinColumn(name="sid")
    private State state;
    
    @ManyToOne
    @JoinColumn(name="cid")
    private Country country;
    
    @Column(name="isdelete")
    private String isdelete;
}
