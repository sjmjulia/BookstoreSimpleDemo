package dto;

/**
 * Created by julia on 5/28/17.
 */
public class ResultDTO {
    private int status;

    public ResultDTO(int status) {
        this.status = status;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
}
